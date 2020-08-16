class AddAuthTokenToVisitors < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :auth_token, :string
    add_index :visitors, :auth_token, unique: true
  end
end
