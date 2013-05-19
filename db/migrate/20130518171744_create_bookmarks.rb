class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :story, null: false
      t.references :user, null: false
      t.string :paragraph, null: false

      t.timestamps
    end

    add_index :bookmarks, [:user_id, :story_id], unique: true

    add_column :stories, :paragraph_count, :integer, default: 0
  end
end
