class AddJsonDataToFollowers < ActiveRecord::Migration[5.1]
  def change
    add_column :followers, :json_data, :string
  end
end
