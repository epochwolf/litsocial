class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title
      t.integer :user_id
      t.integer :stories_count, :default => 0
      t.timestamps
    end
  end
end
