class PoemsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_poem, :except => [:index, :new, :create]
  before_filter :new_poem, :only => [:new, :create]
  before_filter :check_permissions, :only => [:edit, :update, :destroy]
  
  def index
    @poems = paged(Poem.includes(:user))
  end
  
  def show
    return show403 "This post has been removed by the author, sorry. :(" unless @poem.visible? || @poem.user == current_user
    @comments = paged(@poem.comments.top_levels.includes(:user, {:children => :user}))
    render :template => "shared/literature"
  end
  
  def new
  end
  
  def create
    if @poem.save
      redirect @poem
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @poem.update_attributes(params[:poem])
      redirect @poem
    else
      render :edit
    end
  end
  
  def destroy
    show403 "Deleting posts isn't supported yet. It should be added soon."
  end
  
  protected
  def find_poem
    @poem = Poem.find(params[:id])
  end
  
  def new_poem
    @poem = current_user.poems.new(params[:poem])
  end
  
  def check_permissions
    show403 "I'm sorry, I can't let you edit this post because it doesn't belong to you." if @poem.user != current_user
  end
end