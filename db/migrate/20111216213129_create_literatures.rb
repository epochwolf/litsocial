class CreateLiteratures < ActiveRecord::Migration
  def change
    create_table :literatures do |t|
      t.string :title,      :null => false
      t.integer :user_id,   :null => false
      t.text :contents,     :null => false
      t.boolean :deleted,   :null => false, :default => false

      t.timestamps
    end
    
    add_index :literatures, [:deleted, :id]
    add_index :literatures, :user_id
  end
end
