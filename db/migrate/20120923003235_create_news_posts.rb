class CreateNewsPosts < ActiveRecord::Migration
  def change
    create_table :news_posts do |t|
      t.string :title,          null: false
      t.text :contents,         null: false
      t.integer :user_id,       null: false
      t.datetime :published_at

      t.timestamps
    end
    add_index :news_posts, :published_at
  end
end
