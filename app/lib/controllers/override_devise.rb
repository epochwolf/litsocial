module Controllers
module OverrideDevise
  
  def authenticate_admin_user!
    authenticate_user!
  end
  
  def current_admin_user
    return false unless user_signed_in?
    current_user.admin? ? current_user : nil
  end
  
  def stored_location_for(resource_or_scope)
    return_path(after_sign_in_path_for(resource_or_scope))
  end
  
  def after_sign_in_path_for(resource_or_scope)
    url_for(current_user)
  end
end
end