class ApplicationController < ActionController::Base
  include Controllers::RedirectProtection
  include Controllers::OverrideDevise
  include Controllers::ManageBookmarks
  include Controllers::Paged  
  protect_from_forgery
  
  helper_method :return_path, :here, :owner?, :admin?

  protected
  def self.require_login(*args)
    before_filter :authenticate_user!, *args
  end

  def handle_record_not_found
    show404
  end
  
  def show403(message=nil)
    respond_to do |type| 
      type.html { render :template => 'errors/403', layout: 'application', :status => 403, :locals => {:message => message} }
      type.all  { render :nothing => true, :status => 403 }
    end
    true
  end
  
  def show404(message=nil)
    begin; raise; rescue; @trace = $!.backtrace.join("\n"); end
    respond_to do |type| 
      type.html { render :template => 'errors/404', layout: 'application', :status => 404, :locals => {:message => message} }
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

  def user_for_paper_trail
    user_signed_in? && current_user
  end

  def info_for_paper_trail
    { :ip_address => request.remote_ip, :user_agent => request.user_agent }
  end
  
  def authenticate_admin!
    unless admin?
      if user_signed_in?
        redirect_to account_path, :notice => "You don't have permission to access the admin panel."
      else
        redirect_to new_user_session_path, :notice => "Please log in to access the admin panel."
      end
    end
  end

  # Devise Stuff
  def after_sign_in_path_for(resource)
    if CookieBookmark.has_bookmarks?(cookies)
      import_bookmarks_path(:return => return_path)
    else
      return_path
    end
  end

  def after_sign_up_path_for(resource)
    if CookieBookmark.has_bookmarks?(cookies)
      import_bookmarks_path(:return => return_path)
    else
      return_path
    end
  end

end
