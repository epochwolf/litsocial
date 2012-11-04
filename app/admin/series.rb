ActiveAdmin.register Series do
  menu :priority => 3, parent: "Users"
  controller do
    with_role :admin

    def scoped_collection
      Series.includes(:user)
    end
  end

  index do 
    column :title do |s|
      "#{link_to s.title, [:admin, s] } (#{s.stories_count} stories)".html_safe
    end
    column :user
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