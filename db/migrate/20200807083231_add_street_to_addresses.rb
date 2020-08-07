class AddStreetToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :street, :string

    #syntax
    # remove_column :table_name, :column_name
    # rename_column :table_name, :old_column, :new_column
    # change_column :table_name, :column_name, :data_type

    add_index :addresses, :street

    #syntax
    # add_index(:table_name, [:column_one, :column_two], unique: true, name: 'index_addresses_on_street')
  end
end
