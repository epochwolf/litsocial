ActiveAdmin.register Literature do
  
  # index do
  #   column :id
  #   column :name do |u|
  #     link_to u.name, admin_user_path(u)
  #   end
  #   column :gender
  #   column :current_sign_in_at
  #   column "Sync w/FB", :sync_with_facebook do |u| u.sync_with_facebook? ? "Yes" : "No" end
  #   column "Autopost", :autopost_to_facebook do |u| u.autopost_to_facebook? ? "Yes" : "No" end
  #   column "TZ", :timezone
  #   column :admin do |u| u.admin? ? "Yes" : "No" end
  #   
  #   column do |f|
  #     link_to("Edit", [:edit, :admin, f], :class => "member_link")
  #   end
  # end
  
  form do |f|
    f.inputs "Content" do
      f.input :user
      f.input :title
      f.input :contents, :as => :html
    end
    f.buttons
  end
  
  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end
  
  before_save do |currm|
    currm.assign_attributes(params[:literature], :role => :admin)
  end
end
