# frozen_string_literal: true

# app/models/follower.rb
class Follower < ApplicationRecord
  has_many :follower_nodes, dependent: :destroy
  has_many :nodes, through: :follower_nodes
  has_one :influencer

  validates :username, :igid, presence: true, uniqueness: true

  scope :approved, -> { where(approved: true).order('length(followers_count) DESC, followers_count DESC') }
  scope :visited, -> { where.not(visited_at: nil) }
  scope :unvisited, -> { where(visited_at: nil) }
  scope :verified, -> { where(verified: true) }
  scope :unparsed, -> { approved.where(parsed_at: nil) }

  def visit
    FollowerService.new(self)
  end

  def json
    JSON.parse(json_data)
  end

  def instagram_path
    "http://www.instagram.com/#{username}"
  end

  def promote!
    ParseService.all_fields(self)
  end

  def self.progress
    (Follower.visited.count / Follower.count.to_f * 100).round(1).to_s + '%'
  end
end
