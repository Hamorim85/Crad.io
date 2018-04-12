class FollowerNode < ApplicationRecord
  belongs_to :follower
  belongs_to :node
end
