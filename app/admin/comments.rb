ActiveAdmin.register ::Comment, as: "SiteComments" do
  menu :priority => 4, parent: "Users"

  controller do
    with_role :admin

    def scoped_collection
      ::Comment.includes(:commentable, :user)
    end
  end

  batch_action :destroy, false # remove batch operations on users


  form do |f|
    f.inputs "Content" do 
      f.input :contents, input_html:{class: 'redactor'}
    end

    f.inputs "Admin" do
      f.input :deleted
      f.input :locked, as: :boolean
      f.input :locked_reason, input_html:{class: 'redactor'}, label: "The administration has the following to say..."
    end

    f.buttons
  end


  action_item :only => [:show, :edit] do

    link_to "Versions", versions_admin_site_comment_path(resource)
  end

  action_item :only => [:show, :edit] do
    link_to "View on Site", resource
  end

  action_item :only => [:versions] do
    link_to "Detailed Report", versions_detailed_admin_site_comment_path(resource)
  end
  
  member_action :versions do
    @object = Comment.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = Comment.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end
end