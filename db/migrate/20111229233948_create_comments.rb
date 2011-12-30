class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :position
      t.integer :parent_id
      t.integer :reply_count
      t.integer :user_id
      t.text :contents
      t.boolean :edited
      t.boolean :deleted
      t.text :deleted_reason

      t.timestamps
    end
    
    change_table :comments do |t|
      t.index [:commentable_type, :commentable_id, :deleted], :name => "index_comments_on_commentable"
      t.index [:parent_id, :position]
      t.index [:user_id]
    end
  end
end
