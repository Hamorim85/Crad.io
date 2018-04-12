class AddIgidToNodes < ActiveRecord::Migration[5.1]
  def change
    add_column :nodes, :igid, :string
  end
end
