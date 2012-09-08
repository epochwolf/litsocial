ActiveAdmin.register User do
  controller do
    with_role :admin
  end

  batch_action :destroy, false # remove batch operations on users

  index do
    selectable_column
    link_column :name
    column :email
    column :admin
    column :banned?
    column :created_at
    column :updated_at
    edit_links
  end


  form do |f|
    f.inputs "Profile" do 
      f.input :name
      f.input :tagline
      f.input :biography, input_html:{class: 'redactor'}

      f.input :email
    end

    f.inputs "Admin" do
      f.input :banned, as: :boolean
      f.input :banned_reason
    end

    f.buttons
  end
  # TODO: Limit fields that are allowed. 
end