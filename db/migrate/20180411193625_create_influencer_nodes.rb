class CreateInfluencerNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :influencer_nodes do |t|
      t.references :influencer, foreign_key: true
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
