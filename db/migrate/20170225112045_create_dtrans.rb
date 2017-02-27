class CreateDtrans < ActiveRecord::Migration[5.0]
  def change
    create_table :dtrans do |t|
      t.integer :stock_id
      t.integer :transaksi_id
      t.integer :dta_qty
      t.integer :dtd_qty
      t.integer :dtt_qty
      t.string :dtd_rsn
      t.string :dtt_rsn
    end
  end
end
