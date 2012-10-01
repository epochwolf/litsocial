class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :to_id,       null: false
      t.integer :from_id,     null: false
      t.text :message,        null: false
      t.boolean :read
      t.boolean :reported

      t.timestamps
    end

    add_index :messages, :to_id
    add_index :messages, :from_id
    add_index :messages, :reported
  end
end
