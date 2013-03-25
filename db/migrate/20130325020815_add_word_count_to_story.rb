class AddWordCountToStory < ActiveRecord::Migration
  def change
    add_column :stories, :word_count, :integer, default: 0
    add_index :stories, :word_count
  end
end
