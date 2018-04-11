class InfluencerCategory < ApplicationRecord
  belongs_to :category
  belongs_to :influencer

  serialize :node_ids, Array

  def nodes
    node_ids.map { |node_id| Node.find(node_id) }
  end
end
