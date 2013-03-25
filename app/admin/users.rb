ActiveAdmin.register User do
  menu :priority => 4
  scope :all
  scope :admins
  scope :members
  scope :banned

  controller do
    with_role :admin
  end

  batch_action :destroy, false # remove batch operations on users

  index do
    selectable_column
    link_column :name
    column :email
    column :admin
    column :banned?
    column :created_at
    column :updated_at
    edit_links
  end


  form do |f|
    f.inputs "Profile" do 
      f.input :name
      f.input :tagline
      f.input :biography, input_html:{class: 'redactor'}

      f.input :email
    end

    f.inputs "Admin" do
      f.input :banned, as: :boolean
      f.input :banned_reason
    end

    f.buttons
  end
  # TODO: Limit fields that are allowed. 

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
    @object = User.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = User.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end
end