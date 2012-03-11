class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.integer :user_id,       :null => false
      t.string :watchable_type, :null => false
      t.integer :watchable_id,  :null => false
      t.boolean :public,        :null => false, :default => true
      
      # Fields for when watchable_type is User
      t.boolean :stories,       :null => false, :default => false
      t.boolean :poems,         :null => false, :default => false
      t.boolean :journals,      :null => false, :default => false

      t.timestamps
    end
    
    change_table :watches do |t|
      t.index [:user_id, :watchable_type, :watchable_id], :unqiue => true, :name => "idx_watch_user_watchable"
      t.index [:watchable_type, :watchable_id], :name => "idx_watch_watchable"
    end
  end
end
