class CreateNotification < ActiveRecord::Migration[5.0]
  def up
    create_table :notifications do |t|
      t.references :owner
      t.references :recipient
      t.string :key_message
      t.boolean :readStat_receiver
      t.boolean :readStat_admin
      t.boolean :readStat_manager
    end
    
    add_foreign_key :notifications, :users, primary_key: :user_id, column: :owner_id
    add_foreign_key :notifications, :outlets, primary_key: :outlet_id, column: :recipient_id

  end

  def down
    drop_table :notifications
  end
end
