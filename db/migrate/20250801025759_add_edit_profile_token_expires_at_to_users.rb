class AddEditProfileTokenExpiresAtToUsers < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:users, :edit_profile_token_expires_at)
      add_column :users, :edit_profile_token_expires_at, :datetime
    end
  end
end
