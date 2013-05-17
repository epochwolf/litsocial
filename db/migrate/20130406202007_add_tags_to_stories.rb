class AddTagsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :tags, :string, array: true, default: []
    add_index :stories, :tags
  end
end
