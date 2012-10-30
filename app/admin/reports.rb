ActiveAdmin.register Report do
  scope :all
  scope "Not Resolved", :not_resolved
  scope :resolved

  actions :index, :show, :edit, :update, :destroy

  batch_action(:resolve,   priority: 1) do |selection| 
    Report.where(id: selection).update_all  resolve: true
    redirect_to collection_path, notice: "Selected rows resolved."
  end
  
  batch_action(:unresolve, priority: 2) do |selection| 
    Report.where(id: selection).update_all  resolve: false
    redirect_to collection_path, notice: "Selected rows unresolved."
  end

  index do
    selectable_column
    link_column :id
    column :reportable
    column :resolved?
    edit_links
  end

  controller do
    with_role :admin

    def scoped_collection
      Report.includes(:reportable)
    end
  end

  form do |f|
    f.inputs do 
      f.input :reason
      f.input :resolved
    end

    f.buttons
  end
end