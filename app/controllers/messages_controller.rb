class MessagesController < ApplicationController
  before_filter :find_user
  before_filter :find_message, only: [:show, :report, :destroy]
  before_filter :new_message, only: [:new, :create]
  layout "messages"

  def index
    @messages = paged(current_user.messages.visible.includes(:from))
  end

  def sent
    # don't hide reported messages so the sender doesn't know if the receiver reported it
    @messages = paged(current_user.sent_messages.includes(:to))
  end

  def show
  end

  def new
  end

  def create
    if @message.save
      redirect_to return_path(messages_path), notice: "Message sent."
    else
      render :new
    end
  end

  def report
    @message.report!
    redirect_to return_path(messages_path), notice: "Message reported."
  end

  def destroy
    @message.destory
    redirect_to return_path(messages_path), notice: "Message deleted."
  end

  protected
  def new_message
    @message = current_user.sent_messages.new(params[:message])
  end

  def find_message
    @message = current_user.messages.visible.find(params[:id])
  end

  def find_user
    redirect_to new_user_session_path unless @user = current_user 
  end
end