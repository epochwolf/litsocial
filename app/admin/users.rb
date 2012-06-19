ActiveAdmin.register User do
  
  index do
    column :id
    column :name do |u|
      link_to u.name, admin_user_path(u)
    end
    column :gender
    column :current_sign_in_at
    column "FB Profile" do |u|
      if u.linked_to_facebook?
        link_to u.facebook_name, u.facebook_profile
      else
        em "No"
      end
    end
    column "TZ", :timezone
    column :admin do |u| u.admin? ? "Yes" : "No" end
    
    column do |f|
      link_to("Edit", [:edit, :admin, f], :class => "member_link")
    end
  end
  
  form do |f|    
    f.inputs "Profile" do
      f.input :name
      f.input :email
      f.input :gender, :as => :select, :collection => User::GENDERS
      f.input :biography, :as => :admin_html
    end
    f.inputs "Flags" do
      f.input :admin
      f.input :never_set_password
      f.input :prevent_login, :hint => "The nuclear option to lock out a user completely."
    end
    f.inputs "Facebook Account" do
      f.input :facebook_token
      f.input :timezone
    end
    f.inputs "Failed Password Lockout" do
      f.input :failed_attempts
      f.input :unlock_token
      f.input :locked_at
    end
    f.buttons
  end
  
  before_save do |currm|
    currm.assign_attributes(params[:user], :role => :admin)
  end
end
