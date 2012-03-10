class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_comment, :only => [:update, :destroy]
  
  def create
    # guards to prevent evil from happening
    return render_error("Bad input") unless params[:comments].is_a? Hash
    return render_error("Unknown commentable_type") unless Comment::COMMENTABLES.include? params[:comments][:commentable_type]
    type = params[:comments][:commentable_type]
    id = params[:comments][:commentable_id]
    commentable = type.constantize.find_by_id(id)
    return render_error("Can't find parent record") unless commentable
    return render_error("Access denied. Parent record is not visible.") unless commentable.visible?
    
    @comment = Comment.new(params[:comments])
    @comment.commentable = commentable
    @comment.user = current_user
    if @comment.save
      render_success
    else
      render_error @comment.errors
    end
  end
  
  def update
    if @comment.update_attributes(params[:comments])
      render_success
    else
      render_error @comment.errors
    end
  end
  
  def destroy
    @comment.deleted = true
    @comment.deleted_reason = ""
    if @comment.save
      render_success
    else
      render_error @comment.errors
    end
  end
  
  protected
  def find_comment
    return render_error("Could not find comment with id \"#{params[:id]}\".") unless @comment = Comment.find_by_id(params[:id])
    return render_error("Access denied.") unless owner?(@comment)
  end
  
  def render_success
    html = render_to_string :partial => "comments/show.html.haml", :locals => {:comment => @comment}
    render :json =>  {:success => true, :html => html, :id => @comment.id}
  end
  
  def render_error(string_or_hash)
    render :json => {:success => false, :errors => (string_or_hash.is_a?(String) ? {:_ => string_or_hash} : string_or_hash) }
  end
end