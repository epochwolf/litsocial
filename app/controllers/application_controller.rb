class ApplicationController < ActionController::Base
  include Controllers::RedirectProtection
  include Controllers::OverrideDevise
  include Controllers::SaveRecord
  include Controllers::Paged
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownAction, :with => :handle_record_not_found
  
  before_filter :log_current_user 
  before_filter :logout_banned_users
  
  helper_method :return_path, :here, :owner?, :admin?

  def info_for_paper_trail
    { :ip_address => request.remote_ip, :user_agent => request.user_agent }
  end
  
  protected
  def handle_record_not_found
    show404
  end
  
  def show403(message=nil)
    respond_to do |type| 
      type.html { render :template => 'errors/403', :status => 403, :locals => {:message => message} }
      type.all  { render :nothing => true, :status => 403 }
    end
    true
  end
  
  def show404(message=nil)
    respond_to do |type| 
      type.html { render :template => 'errors/404', :status => 404, :locals => {:message => message} }
      type.all  { render :nothing => true, :status => 404 }
    end
    true
  end
  
  def admin?
    user_signed_in? && current_user.admin?
  end
  
  def owner?(object)
    if user_signed_in? && object.respond_to?(:user)
      object.user && object.user == current_user
    end
  end
  
  def authenticate_admin!
    unless admin?
      if user_signed_in?
        redirect_to account_path(current_user), :notice => "You don't have permission to access the admin panel."
      else
        redirect_to new_user_session_path, :notice => "Please log in to access the admin panel."
      end
    end
  end
  
  
  
  # FILTERS
  
  def logout_banned_users
    if user_signed_in? && current_user.prevent_login?
      redirect_to root_path, :warning => "Your account has been locked. You'll need to email an administrator to get your account unlocked."
    end
  end
  
  def log_current_user
    request.env["exception_notifier.exception_data"] = {
      # names aren't unique so we do need to include the user's email in the error log.
      :current_user => current_user.try(:attributes).try(:slice, :id, :email, :admin),
    }
  end
end
