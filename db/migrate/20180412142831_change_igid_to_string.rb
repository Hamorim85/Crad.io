class ChangeIgidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :followers, :igid, :string
  end
end
