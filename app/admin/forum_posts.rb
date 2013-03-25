ActiveAdmin.register ForumPost do
  menu :priority => 3

  scope :all
  scope :visible
  scope :deleted

  controller do
    with_role :admin

    def scoped_collection
      ForumPost.includes(:user)
    end
  end

  batch_action(:sink,     priority: 1) do |selection| 
    ForumPost.where(id: selection).update_all  sunk: true
    redirect_to collection_path, notice: "Selected rows sunk."
  end
  batch_action(:unsink,   priority: 2) do |selection| 
    ForumPost.where(id: selection).update_all  sunk: false
    redirect_to collection_path, notice: "Selected rows raised."
  end
  batch_action(:destroy,  priority: 3) do |selection| 
    ForumPost.where(id: selection).update_all  deleted: true
    redirect_to collection_path, notice: "Selected rows deleted."
  end
  batch_action(:undelete, priority: 4) do |selection| 
    ForumPost.where(id: selection).update_all  deleted: false
    redirect_to collection_path, notice: "Selected rows undeleted."
  end

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

  action_item :only => [:show, :edit] do
    link_to "View on Site", resource
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