class InfluencerCategory < ApplicationRecord
  belongs_to :category
  belongs_to :influencer
end
