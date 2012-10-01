class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string    :title,           null: false
      t.text      :contents,        null: false
      t.integer   :user_id,         null: false
      t.integer   :series_id
      t.integer   :series_position
      t.datetime  :locked_at
      t.text      :locked_reason
      t.boolean   :deleted

      t.timestamps
    end

    add_index :stories, :deleted
    add_index :stories, [:locked_at, :deleted]
    add_index :stories, :series_id
    add_index :stories, :user_id
  end
end
