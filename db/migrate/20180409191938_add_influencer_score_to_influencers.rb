class AddInfluencerScoreToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :influencer_score, :integer
  end
end
