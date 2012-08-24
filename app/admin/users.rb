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
    #column :banned?
    column :created_at
    column :updated_at
    edit_links
  end

  # TODO: Limit fields that are allowed. 
end