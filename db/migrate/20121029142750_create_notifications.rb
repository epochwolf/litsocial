class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true
      t.integer :user_id,    null: false
      t.boolean :read
      t.string :template,    null: false
      t.text :data,          null: false

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end
