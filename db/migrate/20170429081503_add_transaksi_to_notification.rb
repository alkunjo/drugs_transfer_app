class AddTransaksiToNotification < ActiveRecord::Migration[5.0]
  def up
    add_column :notifications, :transaksi_id, :integer
    add_foreign_key :notifications, :transaksis, primary_key: :transaksi_id, column: :transaksi_id
  end

  def down
  	remove_reference :notifications, :transaksi, index: true, foreign_key: true
  end
end
