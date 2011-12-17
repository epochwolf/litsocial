class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    request_time = Time.now
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)  
    if @user.persisted?
      if @user.created_at < request_time #user is a new user
        flash[:notice] = "Welcome, #{@user.name}! An account has been created for you."
      else
        flash[:notice] = "Welcome, #{@user.name}!"
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