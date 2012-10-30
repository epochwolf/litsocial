class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user
      t.references :reportable, polymorphic: true
      t.text :reason
      t.boolean :resolved

      t.timestamps
    end

    add_index :reports, :resolved
    add_index :reports, :user_id
    add_index :reports, [:reportable_type, :reportable_id, :user_id], unique: true
  end
end
