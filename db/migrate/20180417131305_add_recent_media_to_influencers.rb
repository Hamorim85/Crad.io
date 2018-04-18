class AddRecentMediaToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :recent_media, :string
  end
end
