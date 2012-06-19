class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name,      :null => false

      t.timestamps
    end

    create_table :categories_stories, :primary => false do |t|
      t.references :category
      t.references :story
    end
    add_index :categories_stories, [:category_id, :story_id], unique: true
  end
end
