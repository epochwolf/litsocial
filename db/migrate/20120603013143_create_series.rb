class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title,        :null => false
      t.text :description
      t.text :story_list_cache
      t.boolean :deleted,     :null => false, :default => false
      t.text :deleted_reason, :null => false, :default => ""

      t.timestamps
    end

    add_column :stories, :series_id, :string
    add_column :stories, :series_position, :integer, default: '1'
    add_index :stories, :series_id

  end
end
