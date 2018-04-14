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

  def promote!
    Influencer.create(
      follower: self,
      username: json['username'],
      full_name: json['full_name'],
      bio: json['biography'],
      external_url: json['external_url'],
      followers_count: json['edge_followed_by']['count'],
      following_count: json['edge_follow']['count'],
      igid: json['id'],
      ig_pic_url: json['profile_pic_url_hd'],
      verified: json['is_verified']
    )
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
