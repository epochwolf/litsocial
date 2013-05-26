ActiveAdmin.register Page do
  menu :priority => 4, parent: "Site"
  
  scope :all
  scope "Published", :visible
  scope :draft

  controller do
    defaults :finder => :find_by_id_or_url
    with_role :admin

    def scoped_collection
      Page.includes(:user)
    end
  end

  batch_action(:publish,  priority: 1) do |selection| 
    Page.where(id: selection).update_all  published: true 
    redirect_to collection_path, notice: "Selected rows published."
  end

  batch_action(:hide,     priority: 2) do |selection| 
    Page.where(id: selection).update_all  published: false
    redirect_to collection_path, notice: "Selected rows hidden."
  end
  
  batch_action :destroy, false # remove batch operations on users

  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end

  index do
    selectable_column
    link_column :title
    column :user
    column :url do |o| link_to "/page/#{o.to_param}", o end
    column :published?
    column :created_at
    column :updated_at 
    edit_links
  end

  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :contents, input_html:{class: 'redactor'}
    end
    f.inputs "Publishing" do
      f.input :url, :hint => "The part after /page/"
      f.input :published
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
    @object = Page.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = Page.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end

end