# frozen_string_literal: true

# app/services/follower_service.rb
class FollowerService
  def initialize(follower)
    @follower = follower

    request
    case @code
    when 403 then wait(30)
    when 404 then remove_follower
    when 200 then update_follower(@doc['graphql']['user'])
    end
  end

  def self.call
    starting_count = Follower.where('visited_at IS null').count + 1
    started = Time.now
    begin
      loop do
        followers = Follower.where('visited_at IS null')
        follower = followers.offset(rand(followers.count)).first
        break if follower.nil?
        follower.visit
        count = starting_count - followers.count
        p "Updated #{count} - Live for #{((Time.now - started) / 60).round} min"
        sleep 1
      end
    rescue StandardError
      wait_time = 30
      p "RESCUED!!! Waiting #{wait_time} seconds"
      sleep wait_time
      retry
    end
  end

  private

  def request
    @doc = HTTParty.get("https://www.instagram.com/#{@follower.username}/")
    @code = @doc.code

    @doc = Nokogiri::HTML(@doc)
    @doc = JSON.parse(
      @doc.at('body').at('script').children.first.text[21..-2]
    )['entry_data']['ProfilePage'].first
  end

  def wait(wait_time)
    p "Waiting #{wait_time} seconds"
    sleep wait_time
  end

  # def json_request
  #   @doc = HTTParty.get("https://www.instagram.com/#{}?__a=1")
  #   @code = @doc.code
  # end

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
      # BUG: Not sure why. I had to gsub the json before saving to avoid a bug
      json_data: follower_data.to_json.gsub('=>', ':').gsub('nil', 'null')
    )
  end
end
