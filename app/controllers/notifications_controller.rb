class NotificationsController < ApplicationController
  before_filter :find_model

  def destroy
    @notification.destroy
    redirect_to return_path(notifications_account_path), notice: "Notification deleted."
  end

  private
  def find_model
    @notification = current_user.notifications.find(params[:id]) if params[:id]
  end
end