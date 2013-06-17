class AddKindleEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kindle_email, :string
  end
end
