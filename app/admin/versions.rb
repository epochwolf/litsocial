ActiveAdmin.register Version do
  
  actions :index, :show
  
  index do 
    column :id do |v|
      link_to v.id, [:admin, v]
    end
    column :item_type
    column :item
    column :event
    column :created_at
    column :whodunnit do |v|
      if v.whodunnit =~ /^\d+$/
        if u = User.find_by_id(v.whodunnit)
          link_to u.name, [:admin, u]
        else
          "Unknown"
        end
      else
         v.whodunnit
      end
    end
    column :ip_address
    column :user_agent
  end
  
end