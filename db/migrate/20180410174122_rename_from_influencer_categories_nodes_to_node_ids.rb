class RenameFromInfluencerCategoriesNodesToNodeIds < ActiveRecord::Migration[5.1]
  def change
    rename_column :influencer_categories, :nodes, :node_ids
  end
end
