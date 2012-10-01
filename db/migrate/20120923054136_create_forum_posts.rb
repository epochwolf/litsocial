class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.string :title,                null: false
      t.text :contents,               null: false
      t.integer :forum_category_id
      t.integer :user_id,             null: false
      t.datetime :bumped_at
      t.boolean :deleted
      t.boolean :sunk

      t.timestamps
    end

    add_index :forum_posts, :forum_category_id
    add_index :forum_posts, :user_id
    add_index :forum_posts, :bumped_at
    add_index :forum_posts, :deleted

    create_table :forum_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
