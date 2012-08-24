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
      t.boolean   :deleted,         null: false, default: false

      t.timestamps
    end
  end
end
