class AddPasswordResetToVisitors < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :password_reset_token, :string
    add_index :visitors, :password_reset_token, unique: true
    add_column :visitors, :password_reset_sent_at, :datetime
  end
end
