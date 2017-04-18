class AddColumnToObats < ActiveRecord::Migration[5.0]
  def up
    # add_column :obats, :kemasan_id, :integer
    # add_column :obats, :bentuk_id, :integer
    # add_column :obats, :indication_id, :integer
    # add_reference :obats, :kemasans, index: true, foreign_key: true
    # add_reference :obats, :bentuks, index: true, foreign_key: true
    # add_reference :obats, :indications, index: true, foreign_key: true
    add_foreign_key :obats, :kemasans, primary_key: :kemasan_id, column: :kemasan_id
    add_foreign_key :obats, :bentuks, primary_key: :bentuk_id, column: :bentuk_id
    add_foreign_key :obats, :indications, primary_key: :indication_id, column: :indication_id
  end

  def down
  	remove_foreign_key :obats, column: :kemasan_id
  	remove_foreign_key :obats, column: :bentuk_id
  	remove_foreign_key :obats, column: :indication_id
  end
end
