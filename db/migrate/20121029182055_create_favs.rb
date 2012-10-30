class CreateFavs < ActiveRecord::Migration
  def change
    create_table :favs do |t|
      t.references :user
      t.references :favable, polymorphic: true

      t.timestamps
    end

    add_index :favs, :user_id
    add_index :favs, [:favable_type, :favable_id, :user_id], unique: true
  end
end
