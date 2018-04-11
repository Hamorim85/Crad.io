class Follower < ApplicationRecord
  has_many :follower_nodes
  has_many :nodes, through: :follower_nodes
  has_one :influencer
end
