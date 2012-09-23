class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title,      null: false
      t.text :contents,     null: false
      t.string :url
      t.integer :user_id,   null: false
      t.boolean :published

      t.timestamps
    end

    add_index :pages, :url
    add_index :pages, :published
  end
end
