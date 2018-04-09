class CreateNodeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :node_categories do |t|
      t.references :category, foreign_key: true
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
