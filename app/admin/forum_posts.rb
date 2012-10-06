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


  action_item :only => [:show, :edit] do
    link_to "Versions", [:versions, :admin, resource]
  end

  action_item :only => [:versions] do
    link_to "Detailed Report", [:versions_detailed, :admin, resource]
  end
  
  
  member_action :versions do
    @object = ForumPost.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = ForumPost.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end
end