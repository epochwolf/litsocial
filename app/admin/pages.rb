ActiveAdmin.register Page do

  controller do
    defaults :finder => :find_by_id_or_url
    with_role :admin

    def scoped_collection
      Page.includes(:user)
    end
  end

  batch_action(:publish,     priority: 1){|selection| selection.update_column :published, true }
  batch_action(:hide,   priority: 2){|selection| selection.update_column :published, false }
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

end