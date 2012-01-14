class ApplicationController < ActionController::Base
  include Controllers::RedirectProtection
  include Controllers::OverrideDevise
  include Controllers::SaveRecord
  include Controllers::Paged
  protect_from_forgery
  helper_method :return_path, :here, :owner?, :admin?
  
  def current_user_if_admin
    current_user.try(:admin?) ? current_user : nil
  end
  
  def show403(message="This page is currently unavailable.")
    render :template => 'errors/403', :layout => nil, :status => 403, :locals => {:message => message}
  end

  def admin?
    user_signed_in? && current_user.admin?
  end
  
  def owner?(object)
    if user_signed_in? && object.respond_to?(:user)
      object.user && object.user == current_user
    end
  end
  
  protected
  def log_current_user
    request.env["exception_notifier.exception_data"] = {
      # names aren't unique so we do need to include the user's email in the error log.
      :current_user => current_user.try(:attributes).try(:slice, :id, :email, :admin),
    }
  end
end
