class AddEngagementRateToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :engagement_rate, :float
  end
end
