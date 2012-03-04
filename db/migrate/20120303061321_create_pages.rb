class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title,      :null => false
      t.text :contents,     :null => false 
      t.string :url,     :null => false, :default => ""
      t.integer :parent_id
      t.integer :user_id,   :null => false
      t.boolean :published, :null => false, :default => false
  
      t.timestamps
    end
    
    add_index :pages, [:published, :title] #sorting
    add_index :pages, :url
    add_index :pages, :parent_id
  end
  
end
