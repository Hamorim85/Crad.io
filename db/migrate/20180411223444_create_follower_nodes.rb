class CreateFollowerNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :follower_nodes do |t|
      t.references :follower, foreign_key: true
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
