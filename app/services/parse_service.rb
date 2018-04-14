# frozen_string_literal: true

# app/services/parse_service.rb
class ParseService
  def initialize(follower, opt = {})
  end

  def self.call
    loop do
      followers = Follower.where(approved: false, parsed_at: nil)
      offset = rand(followers.count)
      influencer = Influencer.new(follower: followers.offset(offset).first)
      break if followers.nil?
      influencer.parse
    end
  rescue
    byebug
  end
end
