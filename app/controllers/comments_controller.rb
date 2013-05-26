class CommentsController < ApplicationController
  require_login 
  before_filter :find_model, only: [:new, :create]
  before_filter :new_comment, only: [:new, :create]
  before_filter :find_comment, only: [:show, :edit, :update, :destroy]
  before_filter :check_for_locked_comment, only: [:edit, :update]
  before_filter :check_for_deleted_comment, only: [:destroy]

  # This is here just so I can show off :)
  def show
    redirect_to polymorphic_path(@commentable, anchor: "comment-#{@comment.id}")
  end

  def new
    render json:{success: true, html: render_to_string("comments/_new", layout: false)}
  end

  def create
    if @comment.save
      render json:{success: true, html: render_to_string("comments/_show", layout: false), comment_id: @comment.id}
    else
      render json:{success: false, html: render_to_string("comments/_new", layout: false)}
    end
  end

  def edit
    render json:{success: true, html: render_to_string("comments/_edit", layout: false)}
  end

  def update
    if @comment.update_attributes(params[:comment])
      render json:{success: true, html: render_to_string("comments/_show", layout: false)}
    else
      render json:{success: false, html: render_to_string("comments/_edit", layout: false)}
    end
  end

  def destroy
    if @comment.update_column :deleted, true
      render json:{success: true, html: render_to_string("comments/_show", layout: false)}
    else
      render json:{success: false, html: render_to_string("comments/_show", layout: false)}
    end
  end

  protected
  def find_model
    klass = params[:comment].try :[], :commentable_type
    id = params[:comment].try :[], :commentable_id
    return render json:{error: "#{klass} does not allow comments."}, status: 422 unless Comment::COMMENTABLES.include?(klass)
    return render json:{error: "#{klass} not found."}, status: 404 unless @commentable = klass.constantize.find_by_id(id)
    return render json:{error: "#{klass} not visible."}, status: 403 unless @commentable.visible?
  end

  def find_comment
    return render json:{error: "Comment not found."}, status: 404 unless @comment = Comment.find_by_id(params[:id])
    return render json:{error: "Not your comment"}, status: 403 unless owner?(@comment) || admin?
    klass = @comment.commentable_type
    return render json:{error: "#{klass} not found."}, status: 404 unless @commentable = @comment.commentable
    return render json:{error: "#{klass} not visible."}, status: 403 unless @commentable.visible?
  end

  def check_for_locked_comment
    render json:{error: "Comment locked."}, status: 403 if @comment.locked? || !admin?
  end

  def check_for_deleted_comment
    render json:{error: "Comment already deleted."} if @comment.deleted?
  end

  def new_comment
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
  end
end