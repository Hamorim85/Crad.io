# frozen_string_literal: true

# app/services/node_service.rb
class FollowerService
  def initialize(follower, opt = {})
    @follower = follower

    opt[:fallback_mode] ? fallback_request : request
    p @doc
    p @code
    case @code
    when 403 then fallback_mode
    when 404 then remove_follower
    when 200 then update_follower(@doc['graphql']['user'])
    end
  end

  private

  def fallback_mode
    p 'Starting fallback mode'
    false
  end

  def request
    @doc = HTTParty.get("https://www.instagram.com/#{@follower.username}?__a=1")
    @code = @doc.code
  end

  def fallback_request
    @doc = HTTParty.get("https://www.instagram.com/#{@follower.username}/")
    @code = @doc.code

    @doc = Nokogiri::HTML(@doc)
    @doc = JSON.parse(
      @doc.at('body').at('script').children.first.text.gsub('window._sharedData = ', '').chomp(';')
    )['entry_data']['ProfilePage'].first
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
