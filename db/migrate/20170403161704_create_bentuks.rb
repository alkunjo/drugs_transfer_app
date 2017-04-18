class CreateBentuks < ActiveRecord::Migration[5.0]
  def up
    create_table :bentuks, id: false do |t|
      t.integer :bentuk_id
      t.string :bentuk_name

      t.timestamps
    end
    execute "ALTER TABLE bentuks ADD PRIMARY KEY (bentuk_id);"
  end

  def down
  	drop_table :bentuks
  end
end
