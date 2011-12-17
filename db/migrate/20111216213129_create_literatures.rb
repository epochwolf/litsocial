class CreateLiteratures < ActiveRecord::Migration
  def change
    create_table :literatures do |t|
      t.string :title
      t.integer :user_id
      t.text :contents
      t.boolean :deleted

      t.timestamps
    end
  end
end
