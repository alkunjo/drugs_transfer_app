class CreateIndications < ActiveRecord::Migration[5.0]
  def up
    create_table :indications, id: false do |t|
      t.integer :indication_id
      t.string :indication_name

      t.timestamps
    end
    execute "ALTER TABLE indications ADD PRIMARY KEY (indication_id);"
  end

  def down
  	drop_table :indications
  end
end
