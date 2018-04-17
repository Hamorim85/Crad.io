class AddMediaScoreToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :media_score, :integer
  end
end
