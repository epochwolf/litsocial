class CreateLiteratures < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title,      :null => false
      t.integer :user_id,   :null => false
      t.text :contents,     :null => false
      t.text :deleted_reason, :null => false, :default => ""
      t.boolean :deleted,   :null => false, :default => false

      t.timestamps
    end
    
    create_table :poems do |t|
      t.string :title,      :null => false
      t.integer :user_id,   :null => false
      t.text :contents,     :null => false
      t.text :deleted_reason, :null => false, :default => ""
      t.boolean :deleted,   :null => false, :default => false
    
      t.timestamps
    end
    
    add_index :stories, [:deleted, :id]
    add_index :stories, :user_id
    
    add_index :poems, [:deleted, :id]
    add_index :poems, :user_id
  end
end
