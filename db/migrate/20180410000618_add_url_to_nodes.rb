class AddUrlToNodes < ActiveRecord::Migration[5.1]
  def change
    add_column :nodes, :url, :string
  end
end
