class AddIgidToFollowers < ActiveRecord::Migration[5.1]
  def change
    add_column :followers, :igid, :bigint
  end
end
