class CreateMessages < ActiveRecord::Migration
  def change
    create_table :received_messages do |t|
      t.integer :message_id,  :null => false
      t.integer :to_id,       :null => false
      
      t.boolean :read,        :null => false, :default => false
      t.boolean :flagged,     :null => false, :default => false
      t.boolean :deleted,     :null => false, :default => false
      
      t.timestamps
    end
    
    add_index :received_messages, [:to_id, :deleted, :created_at], :name => "index_received_messages_to_deleted"
    add_index :received_messages, [:to_id, :read, :created_at], :name => "index_received_messages_to_read"
    add_index :received_messages, [:flagged, :created_at], :name => "index_received_messages_flagged"
    
    create_table :messages do |t|
      t.text :contents,       :null => false
      t.integer :from_id,     :null => false
      t.boolean :flagged,     :null => false, :default => false # this is used so admins can look at reported voilations without reading all messages.
      t.boolean :deleted,     :null => false, :default => false
      t.text :deleted_reason, :null => false, :default => ""

      t.timestamps
    end
    
    add_index :messages, [:from_id, :created_at]
    add_index :messages, [:deleted, :created_at], :name => "index_messages_to_deleted"
  end
end
