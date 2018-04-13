# frozen_string_literal: true

# app/services/node_service.rb
class FollowerService
  def initialize(follower)
    @follower = follower
    url = "https://www.instagram.com/#{@follower.username}?__a=1"
    @doc = HTTParty.get(url)

    case @doc.code
    when 403 then fallback_request
    when 404 then remove_follower
    else
      update_follower(@doc['graphql']['user'])
    end
  end

  private

  def fallback_request
    p "FORBIDDEN: Requesting fallback"

    @doc = Nokogiri::HTML(HTTParty.get("https://www.instagram.com/#{@follower.username}/"))
    @doc = JSON.parse(
      @doc.at('body').at('script').children.first.text.gsub('window._sharedData = ', '').chomp(';')
    )['entry_data']['ProfilePage'].first
    update_follower(@doc['graphql']['user'])
  end

  def remove_follower
    p "DELETE: #{@follower.username} | Not Found..."
    @follower.destroy
  end

  def update_follower(follower_data)
    p "UPDATE: #{@follower.username}"
    followers_count = follower_data['edge_followed_by']['count']
    @follower.update(
      followers_count: followers_count,
      approved: followers_count > 5_000,
      verified: follower_data['is_verified'],
      igid: follower_data['id'],
      visited_at: Time.now,
      # BUG: Not sure why, but I had to gsub the json before saving to avoid a bug
      json_data: follower_data.to_json.gsub('=>', ':').gsub('nil', 'null')
    )
  end
end
