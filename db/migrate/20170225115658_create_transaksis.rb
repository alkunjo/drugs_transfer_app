class CreateTransaksis < ActiveRecord::Migration[5.0]
  def up
    create_table :transaksis, id: false do |t|
      t.integer :transaksi_id
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :trans_status
      t.datetime :asked_at
      t.datetime :dropped_at
      t.datetime :accepted_at
    end
    execute "ALTER TABLE transaksis ADD PRIMARY KEY (transaksi_id);"
  end
  def down
    drop_table :transaksis
  end
end
