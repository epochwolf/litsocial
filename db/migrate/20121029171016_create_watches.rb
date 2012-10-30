class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.references :user
      t.references :watchable, polymorphic: true

      t.timestamps
    end

    add_index :watches, :user_id
    add_index :watches, [:watchable_type, :watchable_id, :user_id], unique: true
  end
end
