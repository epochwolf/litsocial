ActiveAdmin.register ForumPost do
  scope :all
  scope :visible
  scope :deleted

  controller do
    with_role :admin

    def scoped_collection
      ForumPost.includes(:user)
    end
  end

  batch_action(:sink,     priority: 1){|selection| selection.update_column :sunk,    true  }
  batch_action(:unsink,   priority: 2){|selection| selection.update_column :sunk,    false }
  batch_action(:destroy,  priority: 3){|selection| selection.update_column :deleted, true  }
  batch_action(:undelete, priority: 4){|selection| selection.update_column :deleted, false }

  index do
    selectable_column
    link_column :title
    column :user
    column :bumped_at
    column :created_at
    edit_links
  end

  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :contents, input_html:{class: 'redactor'}
    end
    f.inputs "Publishing" do
      f.input :sunk, hint: "Prevents the thread from being bumped by new comments"
      f.input :deleted
    end
    f.buttons
  end

end