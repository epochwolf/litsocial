class CreateNewsPosts < ActiveRecord::Migration
  def change
    create_table :news_posts do |t|
      t.string :title,      :null => false
      t.text :contents,     :null => false 
      t.integer :user_id,   :null => false
      t.boolean :published, :null => false, :default => false

      t.timestamps
    end
  end
end
