# frozen_string_literal: true

# app/models/follower.rb
class Follower < ApplicationRecord
  has_many :follower_nodes, dependent: :destroy
  has_many :nodes, through: :follower_nodes
  has_one :influencer

  validates :username, :igid, presence: true, uniqueness: true

  def visit
    FollowerService.new(self)
  end

  def json
    JSON.parse(json_data)
  end

  def instagram_path
    "http://www.instagram.com/#{username}"
  end

  def promote
    Influencer.new(follower: self)
  end

  def self.approved
    Follower.where(approved: true).order('length(followers_count) DESC, followers_count DESC')
  end

  def self.visited
    Follower.where.not(visited_at: nil)
  end

  def self.unvisited
    Follower.where(visited_at: nil)
  end

  def self.verified
    Follower.where(verified: true)
  end

  def self.visit_new_verified
    Follower.unvisited_verified.each(&:visit)
  end

  def self.unvisited_verified
    Follower.where(verified: true, visited_at: nil)
  end
end
