class ChangeColumnInfluencerScoreFromInfluencers < ActiveRecord::Migration[5.1]
  def change
    change_column :influencers, :influencer_score, :float
  end
end
