ActiveAdmin.register NewsPost do
  menu :priority => 6, parent: "Admin"

  scope :all
  scope "Published", :visible
  scope :draft

  controller do
    with_role :admin

    def scoped_collection
      NewsPost.includes(:user)
    end
  end

  batch_action :destroy, false # remove batch operations on users

  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end

  index do
    link_column :title
    column :user
    column :published_at
    column :created_at
    edit_links
  end

  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :contents, input_html:{class: 'redactor'}
    end
    f.inputs "Publishing" do
      f.input :published_at, as:'datepicker', hint: "This field determines the position of the news post. If blank, the news post is hidden. Right now, future dates are visible."
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
    @object = NewsPost.find(params[:id])
    @versions = @object.versions.select('id, created_at, event, whodunnit, ip_address, user_agent')
    render 'admin/paper_trail.arb'
  end


  member_action :versions_detailed do
    @object = NewsPost.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail_detailed.arb'
  end
end