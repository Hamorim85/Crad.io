# frozen_string_literal: true

class Follower < ApplicationRecord
  has_many :follower_nodes, dependent: :destroy
  has_many :nodes, through: :follower_nodes
  has_one :influencer

  validates :username, :igid, presence: true, uniqueness: true

  def visit(opt = {})
    FollowerService.new(self, opt)
  end

  def json
    JSON.parse(json_data)
  end

  def instagram_path
    "http://www.instagram.com/#{username}"
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
    Follower.unvisited_verified.each do |follower|
      follower.visit(fallback_mode: true)
    end
  end

  def self.unvisited_verified
    Follower.where(verified: true, visited_at: nil)
  end

  def self.visit_task
    count = 0
    started = Time.now
    fallback_mode = false
    begin
      loop do
        offset = rand(Follower.where('visited_at IS null').count)
        follower = Follower.where('visited_at IS null').offset(offset).first
        break if follower.nil?
        p "Visited #{count += 1} - Running for #{((Time.now - started) / 60).round} minutes"

        # Tries to return to normal mode every 50 tries
        fallback_mode = false if (count % 50).zero?

        # Starts fallback_mode if returns false
        next unless follower.visit(fallback_mode: fallback_mode)
        fallback_mode = true
      end
    rescue
      p 'Failed. Waiting 30 seconds'
      sleep 45
      retry
    end
  end
end
