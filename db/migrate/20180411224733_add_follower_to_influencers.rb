class AddFollowerToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_reference :influencers, :follower, foreign_key: true
  end
end
