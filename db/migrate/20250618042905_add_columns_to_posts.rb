class AddColumnsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :address, :string
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
    add_column :posts, :spot, :string
  end
end
