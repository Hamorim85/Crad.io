class RemoveInfluencerScoreFromInfluencers < ActiveRecord::Migration[5.1]
  def change
    remove_column :influencers, :influencer_score
  end
end
