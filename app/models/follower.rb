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

  def self.visit_task
    count = 0
    started = Time.now
    fallback_mode = false
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
  end
end

# Follower.where(approved: true).select(:username, :followers_count).order('length(followers_count), followers_count')
