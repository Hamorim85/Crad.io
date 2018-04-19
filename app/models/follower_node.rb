# frozen_string_literal: true

# app/models/follower_node.rb
class FollowerNode < ApplicationRecord
  belongs_to :follower
  belongs_to :node

  validates :follower, uniqueness: { scope: :node }
end
