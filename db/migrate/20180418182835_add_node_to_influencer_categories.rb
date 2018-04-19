class AddNodeToInfluencerCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :influencer_categories, :node, foreign_key: true
  end
end
