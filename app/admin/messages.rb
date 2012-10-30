ActiveAdmin.register Message do

  actions :index, :show, :edit, :update, :destroy

  controller do
    with_role :admin

    def scoped_collection
      Message.admin_visible.includes(:to, :from)
    end
  end

  batch_action(:unreport,     priority: 1) do |selection| 
    Message.where(id: selection).update_all  reported: false 
    redirect_to collection_path, notice: "Selected rows unreported"
  end

  form do |f|
    f.inputs "Publishing" do
      f.input :reported
    end
    f.buttons
  end

end