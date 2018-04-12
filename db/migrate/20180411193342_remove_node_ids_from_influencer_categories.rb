class RemoveNodeIdsFromInfluencerCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :influencer_categories, :node_ids
  end
end
