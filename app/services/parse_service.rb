# frozen_string_literal: true

# app/services/parse_service.rb
class ParseService
  def initialize(follower, opt = {})
  end

  def self.call
    loop do
      followers = Follower.where(approved: false, parsed_at: nil)
      offset = rand(followers.count)
      influencer = followers.offset(offset).first.promote!
      break if followers.nil?
      influencer.parse_all
      influencer.save
    end
  rescue
    byebug
  end
end
