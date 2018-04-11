# frozen_string_literal: true

# app/services/request_service.rb
class RequestService
  def initialize(node, user_hash, options = {})
    # @node = node
    # @next_page_key = ''

    @followers = []
    @node = node
    @user_hash = user_hash
    @next_page_key = options[:page_key]

    # @node.igid = '248701561'
    # @user_hash = '37479f2b8209594dde7facb0d904896a'
    @followers_per_request = 5500
    # @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables={'id':'#{@node.igid}','first':#{@followers_per_request}}"
    @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%22#{@node.igid}%22%2C%22first%22%3A#{@followers_per_request}%7D"
    @headers = {
      cookie: 'csrftoken=9Ap16hxUPvUvXiF6ty9bqBL4EKcET1LH; mid=WsPmowAEAAElyaSAVGMYolTRQLa1; _js_datr=ooTLWv0eRYgs5fEmyZycQO6e; rur=FTW; ig_vw=1879; ig_pr=1; ig_vh=982; ig_or=landscape-primary; urlgen="{\"time\": 1523459409\054 \"185.210.217.141\": 9009}:1f6MDz:fk783yZI-M2Iq4Q2leXrLAX6DSM"; fbm_124024574287414=base_domain=.instagram.com; shbid=1598; ds_user_id=525171759; sessionid=IGSC0564083aaaa790d9232bdfddbb99961c435ace39d6ea44e29177b998e8369618%3AyejRMV1UUo9ISBbP1uhlW0WFwvxgMeNl%3A%7B%22_auth_user_id%22%3A525171759%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_auth_user_hash%22%3A%22%22%2C%22_platform%22%3A4%2C%22_token_ver%22%3A2%2C%22_token%22%3A%22525171759%3ANvcrE0urwtWsLtMb5klGyDgupBMNYh0i%3A53387db6cdcc64f3ac6e236986ced77e1c8e20a66c6e13d2762e1b1c6f4dfebb%22%2C%22last_refreshed%22%3A1523459793.5128288269%7D; fbsr_124024574287414=db_WqwDSNCCyHnZj7-6PfVuHDXMw_GFKZifYBzjWS6s.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUNYcDB4RnJRWjEtN0ZWWTJHdUkwNHVMT1pUaE5tVlFrNjVkZmtiT2hxbTltVzhTZkhIOEVEQmFHSkkzY0hUMmdmajdoMzI3NWdva01CeFRQLUtZbE1veGctbTk1SzB0am1scEhibjRLaUt6Y0h0SER6T1dfLUpGa3F6ci1LRDdLMjl3ekI3Vjc3WUVOTmJXRjJ0bmttYlJYNE8tQllDeXZKWjc3eWRSMHRpa0JZdUlpWllRcDJxNl9TbTlDSnRreU5GWWFwa0xNampJcTdCYjlmQ0ZTVHZTbnZ2czNuYTBVVUxEQkVNSUk1Ni1DcnR3TzRuTzV4Skp0a0djWVZpQ3hqY1ctVmxfUURpQ0RPNDJuT3pzQzlwVFZrU0ZwYVhWaEF4T0NyYjZEZDdrQVVRRnVfMUJmNjRGWGx1TlpWaVlUSE9ZVU9lbm4tc0dXU3FXZ2VEeV9lVyIsImlzc3VlZF9hdCI6MTUyMzQ3Nzc4MSwidXNlcl9pZCI6IjUyMTg4MTExMSJ9'
    }
    @next_page_key ? keep_going : start
  end

  private

  def start
    p 'Requesting first page...'
    doc = HTTParty.get(@curl, headers: @headers)
    doc = doc['data']['user']['edge_followed_by']
    followers = doc['edges']

    # Iterates through followers and adds them to the DB
    add_followers(followers)

    @next_page_key = doc['page_info']['end_cursor']
    keep_going
  end

  def keep_going
    counter = 0
    loop do
      p "Request \##{counter += 1}..."
      # @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables={'id':'#{@node.igid}','first':#{@followers_per_request},'after':'#{@next_page_key}'}"
      @curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%22#{@node.igid}%22%2C%22first%22%3A#{@followers_per_request}%2C%22after%22%3A%22#{@next_page_key}%22%7D"

      doc = HTTParty.get(@curl, headers: @headers)
      doc = doc['data']['user']['edge_followed_by']
      followers = doc['edges']

      # Iterates through followers and adds them to the DB
      add_followers(followers)

      @next_page_key = doc['page_info']['end_cursor']

      break if @next_page_key.nil?
      p "Next key is: #{@next_page_key}"
    end
  end

  def add_followers(followers)
    followers.each do |follower|
      follower = Follower.find_or_initialize_by(username: follower['username'])
      follower.nodes << @node unless follower.nodes.include?(@node)
      follower.update(verified: follower['is_verified'])
    end
  end
end
