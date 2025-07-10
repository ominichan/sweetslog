class AddColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :edit_profile_token, :string
  end
end
