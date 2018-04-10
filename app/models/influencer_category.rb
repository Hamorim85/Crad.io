class InfluencerCategory < ApplicationRecord
  belongs_to :category
  belongs_to :influencer

  serialize :nodes, Array
end
