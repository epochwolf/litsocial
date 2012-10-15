class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :user,    null: false
      t.references :parent
      t.text     :contents,  null: false
      t.datetime :locked_at
      t.text     :locked_reason
      t.boolean  :edited
      t.boolean  :deleted

      t.timestamps
    end
    
    add_index :comments, [:commentable_type, :commentable_id], :name => "index_comments_on_commentable"
    add_index :comments, :user_id
  end
end
