# frozen_string_literal: true

# app/services/node_service.rb
class FollowerService
  def initialize(follower)
    url = "https://www.instagram.com/#{follower.username}?__a=1"
    doc = HTTParty.get(url)['graphql']['user']

    followers_count = doc['edge_follow']['count']
    follower.update(
      followers_count: followers_count,
      approved: followers_count > 5_000,
      verified: doc['is_verified'],
      visited_at: Time.now,
      # BUG: Not sure why, but I had to gsub the json before saving to avoid a bug
      json_data: doc.to_json.gsub('=>', ':').gsub('nil', 'null')
    )
  end
end
