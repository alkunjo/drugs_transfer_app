class CreateKemasans < ActiveRecord::Migration[5.0]
  def up
    create_table :kemasans, id: false do |t|
      t.integer :kemasan_id
      t.string :kemasan_kode
      t.string :kemasan_name

      t.timestamps
    end
    execute "ALTER TABLE kemasans ADD PRIMARY KEY (kemasan_id);"
  end
  
  def down
  	drop_table :kemasans
  end
end
