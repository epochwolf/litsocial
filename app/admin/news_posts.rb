ActiveAdmin.register NewsPost do


  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end
  
  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :contents, :as => :html
    end
    f.inputs "Publishing" do
      f.input :user
      f.input :published
    end
    f.buttons
  end
  
end