ActiveAdmin.register NewsPost do

  controller do
    with_role :admin

    def scoped_collection
      NewsPost.includes(:user)
    end
  end

  batch_action(:publish,     priority: 1){|selection| selection.update_column :published, true }
  batch_action(:hide,   priority: 2){|selection| selection.update_column :published, false }

  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end

  index do
    selectable_column
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

end