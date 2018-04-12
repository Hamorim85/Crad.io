class DropInfluencerNodes < ActiveRecord::Migration[5.1]
  def change
    drop_table :influencer_nodes
  end
end
