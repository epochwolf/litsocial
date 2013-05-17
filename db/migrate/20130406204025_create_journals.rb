class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :title
      t.text :contents
      t.string :tags, array: true, default: []
      t.references :user
      t.boolean :draft
      t.datetime  :locked_at
      t.text      :locked_reason
      t.boolean   :deleted

      t.timestamps
    end
    add_index :journals, :user_id
  end
end
