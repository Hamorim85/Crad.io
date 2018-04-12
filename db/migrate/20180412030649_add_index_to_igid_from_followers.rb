class AddIndexToIgidFromFollowers < ActiveRecord::Migration[5.1]
  def change
    add_index :followers, :igid
  end
end
