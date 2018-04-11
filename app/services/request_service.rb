# frozen_string_literal: true
#
# curl 'https://www.instagram.com/graphql/query/?query_hash=37479f2b8209594dde7facb0d904896a&variables=%7B%22id%22%3A%22249655166%22%2C%22first%22%3A20%7D'
# 'Accept: */*' --compressed
# 'Accept-Language: en-US,en;q=0.5'
# 'Connection: keep-alive'
# 'Cookie: csrftoken=9Ap16hxUPvUvXiF6ty9bqBL4EKcET1LH; mid=WsPmowAEAAElyaSAVGMYolTRQLa1; _js_datr=ooTLWv0eRYgs5fEmyZycQO6e; rur=FTW; ig_vw=1879; ig_pr=1; ig_vh=982; ig_or=landscape-primary; urlgen="{\"time\": 1523459409}:1f6HUQ:ATLIq5I-boUcXbWW-jhyzhQW5Sw"; fbm_124024574287414=base_domain=.instagram.com; fbsr_124024574287414=3cXTmZdfZTggUPl5JfrpqFqknDRFCLeswqZeMf_xTTI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJRckFIX3lhX00yMUNMbHpXeHZoZkJGTDc0eG95aFNJY0M1d1RVMGpzOTk0YklhbFdYZkZjVG5yY3RoM0VIdDA3anJFVTN0YlVUbk9qRXQtQkZoYUtsMFN0VXA1a3pic2htMEVPbXptelhncEE4Tk9IQVRmRDBfM3pCSjg5NkdOMXRFVHhGU0NHU3RiVlZIS0tsNzdGbmQyZFg3Ujl5ajNRT0FjQTA2Z2pOQmRaaU96bXBMNkpZSmFQSTNNQW8wa0d6UkszQTNadTZ0eHN1VU5FTk1nRjRjVHdKaEMyekk5Y0NWaG1KeWVkOEhHdm5abXJycG5qb0pXVXQ2SXBZREFSdGNKeHRWNWJrSi1XTkdGSF9hOEN6TWlYUVc3X1Y1c09pZEtYYUN0eG9kWDkzNHFOVFhFRG9BSzN0MUYtaC1qMWF5NXp1eERTbHBtUmF6MFJlOGxyNSIsImlzc3VlZF9hdCI6MTUyMzQ1OTc5NSwidXNlcl9pZCI6IjUyMTg4MTExMSJ9; shbid=1598; ds_user_id=525171759; sessionid=IGSC0564083aaaa790d9232bdfddbb99961c435ace39d6ea44e29177b998e8369618%3AyejRMV1UUo9ISBbP1uhlW0WFwvxgMeNl%3A%7B%22_auth_user_id%22%3A525171759%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_auth_user_hash%22%3A%22%22%2C%22_platform%22%3A4%2C%22_token_ver%22%3A2%2C%22_token%22%3A%22525171759%3ANvcrE0urwtWsLtMb5klGyDgupBMNYh0i%3A53387db6cdcc64f3ac6e236986ced77e1c8e20a66c6e13d2762e1b1c6f4dfebb%22%2C%22last_refreshed%22%3A1523459793.5128288269%7D'
# 'Host: www.instagram.com'
# 'Referer: https://www.instagram.com/cocacola/followers/'
# 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:59.0) Gecko/20100101 Firefox/59.0'
# 'X-Instagram-GIS: 992789b58d20d26cd6fa87da6e3a130c'
# 'X-Requested-With: XMLHttpRequest'

# app/services/request_service.rb
class RequestService
  def initialize(node_id, user_hash)
    followers = []

    # @node = node
    # @node_id = '22248701561'
    # @user_hash = '37479f2b8209594dde7facb0d904896a'
    # @next_page_key = ''

    @node_id = node_id
    @user_hash = user_hash
    @next_page_key = ''

    curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%#{@node_id}%22%2C%22first%22%3A20%7D"
    # curl = "https://www.instagram.com/graphql/query/?query_hash={37479f2b8209594dde7facb0d904896a}&variables=%7B%22id%22%3A%{22249655166}%22%2C%22first%22%3A20%7D"
    headers = {
      cookie: 'csrftoken=9Ap16hxUPvUvXiF6ty9bqBL4EKcET1LH; mid=WsPmowAEAAElyaSAVGMYolTRQLa1; _js_datr=ooTLWv0eRYgs5fEmyZycQO6e; rur=FTW; ig_vw=1879; ig_pr=1; ig_vh=982; ig_or=landscape-primary; urlgen="{\"time\": 1523459409}:1f6HUQ:ATLIq5I-boUcXbWW-jhyzhQW5Sw"; fbm_124024574287414=base_domain=.instagram.com; fbsr_124024574287414=3cXTmZdfZTggUPl5JfrpqFqknDRFCLeswqZeMf_xTTI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJRckFIX3lhX00yMUNMbHpXeHZoZkJGTDc0eG95aFNJY0M1d1RVMGpzOTk0YklhbFdYZkZjVG5yY3RoM0VIdDA3anJFVTN0YlVUbk9qRXQtQkZoYUtsMFN0VXA1a3pic2htMEVPbXptelhncEE4Tk9IQVRmRDBfM3pCSjg5NkdOMXRFVHhGU0NHU3RiVlZIS0tsNzdGbmQyZFg3Ujl5ajNRT0FjQTA2Z2pOQmRaaU96bXBMNkpZSmFQSTNNQW8wa0d6UkszQTNadTZ0eHN1VU5FTk1nRjRjVHdKaEMyekk5Y0NWaG1KeWVkOEhHdm5abXJycG5qb0pXVXQ2SXBZREFSdGNKeHRWNWJrSi1XTkdGSF9hOEN6TWlYUVc3X1Y1c09pZEtYYUN0eG9kWDkzNHFOVFhFRG9BSzN0MUYtaC1qMWF5NXp1eERTbHBtUmF6MFJlOGxyNSIsImlzc3VlZF9hdCI6MTUyMzQ1OTc5NSwidXNlcl9pZCI6IjUyMTg4MTExMSJ9; shbid=1598; ds_user_id=525171759; sessionid=IGSC0564083aaaa790d9232bdfddbb99961c435ace39d6ea44e29177b998e8369618%3AyejRMV1UUo9ISBbP1uhlW0WFwvxgMeNl%3A%7B%22_auth_user_id%22%3A525171759%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_auth_user_hash%22%3A%22%22%2C%22_platform%22%3A4%2C%22_token_ver%22%3A2%2C%22_token%22%3A%22525171759%3ANvcrE0urwtWsLtMb5klGyDgupBMNYh0i%3A53387db6cdcc64f3ac6e236986ced77e1c8e20a66c6e13d2762e1b1c6f4dfebb%22%2C%22last_refreshed%22%3A1523459793.5128288269%7D'
    }

    doc = HTTParty.get(curl, headers: headers)
    p doc
    doc = doc['data']['user']['edge_followed_by']
    followers += doc['edges']
    @next_page_key = doc['page_info']['end_cursor']


    counter = 0
    loop do
      p "Request \##{counter += 1}"
      doc = HTTParty.get(curl, headers: headers)['data']['user']['edge_followed_by']

      curl = "https://www.instagram.com/graphql/query/?query_hash=#{@user_hash}&variables=%7B%22id%22%3A%#{@node_id}%22%2C%22first%22%3A10%2C%22after%22%3A%22#{@next_page_key}%22%7D"

      # follow_page = doc['data']['user']['edge_followed_by']
      followers += doc['edges']

      @next_page_key = doc['page_info']['end_cursor']

      break if @next_page_key.nil?

      p "Next key is: #{@next_page_key}"
    end
  end
end
