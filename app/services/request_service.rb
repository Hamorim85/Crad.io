# frozen_string_literal: true

# app/services/request_service.rb
class RequestService
  def initialize(node_id, user_hash, options = {})
    # @node = node
    # @next_page_key = ''

    @followers = []
    @node_id = node_id
    @user_hash = user_hash
    @next_page_key = options[:page_key]

    # @node_id = '22248701561'
    # @user_hash = '37479f2b8209594dde7facb0d904896a'
    @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%#{@node_id}%22%2C%22first%22%3A20%7D"
    @headers = { cookie: 'csrftoken=9Ap16hxUPvUvXiF6ty9bqBL4EKcET1LH; mid=WsPmowAEAAElyaSAVGMYolTRQLa1; _js_datr=ooTLWv0eRYgs5fEmyZycQO6e; rur=FTW; ig_vw=1879; ig_pr=1; ig_vh=982; ig_or=landscape-primary; urlgen="{\"time\": 1523459409}:1f6HUQ:ATLIq5I-boUcXbWW-jhyzhQW5Sw"; fbm_124024574287414=base_domain=.instagram.com; fbsr_124024574287414=3cXTmZdfZTggUPl5JfrpqFqknDRFCLeswqZeMf_xTTI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJRckFIX3lhX00yMUNMbHpXeHZoZkJGTDc0eG95aFNJY0M1d1RVMGpzOTk0YklhbFdYZkZjVG5yY3RoM0VIdDA3anJFVTN0YlVUbk9qRXQtQkZoYUtsMFN0VXA1a3pic2htMEVPbXptelhncEE4Tk9IQVRmRDBfM3pCSjg5NkdOMXRFVHhGU0NHU3RiVlZIS0tsNzdGbmQyZFg3Ujl5ajNRT0FjQTA2Z2pOQmRaaU96bXBMNkpZSmFQSTNNQW8wa0d6UkszQTNadTZ0eHN1VU5FTk1nRjRjVHdKaEMyekk5Y0NWaG1KeWVkOEhHdm5abXJycG5qb0pXVXQ2SXBZREFSdGNKeHRWNWJrSi1XTkdGSF9hOEN6TWlYUVc3X1Y1c09pZEtYYUN0eG9kWDkzNHFOVFhFRG9BSzN0MUYtaC1qMWF5NXp1eERTbHBtUmF6MFJlOGxyNSIsImlzc3VlZF9hdCI6MTUyMzQ1OTc5NSwidXNlcl9pZCI6IjUyMTg4MTExMSJ9; shbid=1598; ds_user_id=525171759; sessionid=IGSC0564083aaaa790d9232bdfddbb99961c435ace39d6ea44e29177b998e8369618%3AyejRMV1UUo9ISBbP1uhlW0WFwvxgMeNl%3A%7B%22_auth_user_id%22%3A525171759%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_auth_user_hash%22%3A%22%22%2C%22_platform%22%3A4%2C%22_token_ver%22%3A2%2C%22_token%22%3A%22525171759%3ANvcrE0urwtWsLtMb5klGyDgupBMNYh0i%3A53387db6cdcc64f3ac6e236986ced77e1c8e20a66c6e13d2762e1b1c6f4dfebb%22%2C%22last_refreshed%22%3A1523459793.5128288269%7D' }
    @next_page_key ? keep_going : start
  end

  private

  def start
    p 'Requesting first page...'
    doc = HTTParty.get(@curl, headers: @headers)
    doc = doc['data']['user']['edge_followed_by']

    # Iterates through followers and adds them to the DB
    followers = doc['edges']
    add_influencers(followers)

    @next_page_key = doc['page_info']['end_cursor']
    keep_going
  end

  def keep_going
    counter = 0
    loop do
      p "Request \##{counter += 1}..."
      doc = HTTParty.get(@curl, headers: @headers)
      doc = doc['data']['user']['edge_followed_by']

      @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%#{@node_id}%22%2C%22first%22%3A10%2C%22after%22%3A%22#{@next_page_key}%22%7D"
      p doc['edges']
      @followers += doc['edges']

      @next_page_key = doc['page_info']['end_cursor']

      break if @next_page_key.nil?

      p "Next key is: #{@next_page_key}"
    end
  end

  def add_influencers(followers)
    followers.each do |follower|
      influencer = Influencer.find_or_initialize_by(username: follower['username'])
      influencer.update(
        igid: follower['id'],
        full_name: follower['full_name'],
        photo: follower['profile_pic_url'],
        verified: follower['is_verified']
      )
    end
  end
end
