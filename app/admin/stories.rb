ActiveAdmin.register Story do
  scope :all
  scope :visible
  scope :locked
  scope :deleted

  controller do
    with_role :admin

    def scoped_collection
      Story.includes(:user)
    end
  end

  batch_action(:lock,     priority: 1){|selection| selection.update_column :locked_at, DateTime.now }
  batch_action(:unlock,   priority: 2){|selection| selection.update_column :locked_at, nil          }
  batch_action(:destroy,  priority: 3){|selection| selection.update_column :deleted, true           }
  batch_action(:undelete, priority: 4){|selection| selection.update_column :deleted, false          }


  index do
    selectable_column
    link_column :title
    column :user
    column :series_id
    column :series_position
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
    end

    f.inputs "Series" do
      f.input :series
      f.input :series_position
    end

    f.inputs "Admin" do
      f.input :deleted
      f.input :locked, as: :boolean
      f.input :locked_reason, input_html:{class: 'redactor'}, label: "The administration has the following to say..."
    end

    f.buttons
  end
end