class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :name,                   :null => false
      t.string :gender
      t.string :timezone
      t.boolean :admin,                 :null => false, :default => false
      t.text :biography,                :null => false, :default => ''
      t.text :facebook_data
      t.boolean :never_set_password,    :null => false,  :default => false
      t.boolean :autopost_to_facebook,  :null => false,  :default => false
      t.boolean :sync_with_facebook,    :null => false,  :default => true
    
      t.database_authenticatable :null => false
      t.string :facebook_token
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :name,                 :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

end
