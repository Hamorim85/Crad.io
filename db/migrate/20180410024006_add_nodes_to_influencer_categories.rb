class AddNodesToInfluencerCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :influencer_categories, :nodes, :string
  end
end
