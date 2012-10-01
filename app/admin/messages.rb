ActiveAdmin.register Message do

  actions :index, :show, :edit, :update, :destroy

  controller do
    with_role :admin

    def scoped_collection
      Message.admin_visible.includes(:to, :from)
    end
  end

  batch_action(:unreport,     priority: 1){|selection| selection.update_column :reported,    false }

  form do |f|
    f.inputs "Publishing" do
      f.input :reported
    end
    f.buttons
  end

end