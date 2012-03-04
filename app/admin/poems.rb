ActiveAdmin.register Poem do
  
  index do 
    column :id
    column :title do |l|
      link_to l.title, [:admin, l]
    end
    column :user
    column :created_at
    column :deleted do |l| l.deleted? ? "Yes" : "No" end
  end
  
  form do |f|
    f.inputs "Content" do
      f.input :user
      f.input :title
      f.input :contents, :as => :html
    end
    f.inputs "Deletion" do
      f.input :deleted
      f.input :deleted_reason
    end
    f.buttons
  end
  
  # set the user for this model
  before_build do |currm|
    currm.user = current_user
  end
  
  before_save do |currm|
    currm.assign_attributes(params[:poem], :role => :admin)
  end
  
  action_item :only => [:show, :edit] do
    link_to "Versions", [:versions, :admin, resource]
  end
  
  member_action :versions do
    @object = Poem.find(params[:id])
    @versions = @object.versions
    render 'admin/paper_trail.arb'
  end
  
end
