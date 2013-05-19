ActiveAdmin.register Journal do
  menu :priority => 3
  scope :all
  scope :visible
  scope :is_locked
  scope :deleted

  controller do
    with_role :admin

    def scoped_collection
      Journal.includes(:user)
    end
  end

  batch_action(:lock,     priority: 1) do |selection| 
    Journal.where(id: selection).update_all locked_at: DateTime.now 
    redirect_to collection_path, notice: "Selected rows locked."
  end

  batch_action(:unlock,   priority: 2) do |selection| 
    Journal.where(id: selection).update_all  locked_at: nil
    redirect_to collection_path, notice: "Selected rows unlocked."
  end

  batch_action(:destroy,  priority: 3) do |selection| 
    Journal.where(id: selection).update_all  deleted: true
    redirect_to collection_path, notice: "Selected rows deleted."
  end

  batch_action(:undelete, priority: 4) do |selection| 
    Journal.where(id: selection).update_all  deleted: false
    redirect_to collection_path, notice: "Selected rows undeleted."
  end


  index do
    selectable_column
    link_column :title
    column :user
    column "Tags", :tag_list
    column :draft?
    column :deleted?
    column :locked?
    column :created_at
    column :updated_at 
    edit_links
  end

  form do |f|
    f.inputs "Content" do 
      f.input :title
      f.input :contents, input_html:{class: 'redactor'}
      f.input :draft
      f.input :tag_list, as: :string, hint: "Comma separated"
    end

    f.inputs "Admin" do
      f.input :deleted
      f.input :locked, as: :boolean
      f.input :locked_reason, input_html:{class: 'redactor'}, label: "The administration has the following to say..."
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
    @object = Journal.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = Journal.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end
end