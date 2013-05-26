ActiveAdmin.register ForumCategory do
  menu :priority => 2, parent: "Site"

  controller do
    with_role :admin
  end

  index do
    selectable_column
    link_column :title
    column :created_at
    column :updated_at
    edit_links
  end

  form do |f|
    f.inputs "Content" do
      f.input :title
    end
    f.buttons
  end

end