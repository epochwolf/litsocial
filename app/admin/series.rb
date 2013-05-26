ActiveAdmin.register Series do
  menu :priority => 2, parent: "Users"
  
  controller do
    with_role :admin

    def scoped_collection
      Series.includes(:user)
    end
  end

  action_item :only => [:show, :edit] do
    link_to "View on Site", resource
  end

  show do |series|
    attributes_table do
      row :id
      row :title
      row :user
      row :stories_count
      row "Stories" do 
        ol do
          series.stories.each do |story|
            li do 
              link_to(story.title, [:admin, story]) + raw(story.locked? ? " (Locked)" : "") + raw(story.deleted? ? " (Deleted)" : " ")
            end
          end
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
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