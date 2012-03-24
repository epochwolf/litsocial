class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)  
    if @user.persisted?
      if @user.new_from_facebook 
        flash[:notice] = "Welcome, #{@user.name}! An account has been created for you. You can review your account details by clicking the My Account link at the top of your screen."
      elsif @user.just_linked_to_facebook
        flash[:notice] = "Welcome back, #{@user.name}. Your account has been linked to your facebook profile."
      else
        flash[:notice] = "Welcome back, #{@user.name}."
      end
      sign_in_and_redirect @user, :event => :authentication
    else
      # If there is an issue with facebook, punt it to devise to fill in
      # We lose a done of data but we can retrieve that next time they log in with facebook
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
end