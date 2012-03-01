class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_account
  before_filter :find_message, :except => [:index, :read, :sent, :new, :create]
  before_filter :new_message, :only => [:new, :create]
  
  def index
    @messages = paged(@user.received_messages.visible.unread)
  end
  
  def read
    @messages = paged(@user.received_messages.visible.read)
    render :index
  end
  
  def sent
    @messages = paged(@user.sent_messages)
    render :index
  end
  
  def show
  end
  
  def new
  end
  
  def create
    if @message.save
      redirect sent_account_messages_path(@user)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @message.update_attributes(params[:message])
      redirect account_messages_path(@user)
    else
      render :new
    end
  end
  
  def destroy
    raise "Not Implemented"
  end
  
  protected
  def find_account
    if current_user.id.to_s != (params[:account_id]).to_s
      redirect_to account_path(current_user)
    else
      @user = User.find(params[:account_id])
    end
  end
  
  def find_message
    @message = @user.received_messages.find_by_message_id(params[:id])
  end
  
  def new_message
    params[:message] = {:to_ids => params[:to]} if params[:message].nil? && params[:to]
    @message = @user.sent_messages.build(params[:message], :role => :sender)
  end
end