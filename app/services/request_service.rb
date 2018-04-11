# frozen_string_literal: true

# app/services/request_service.rb
class RequestService
  def initialize(node)
    url = 'https://www.instagram.com/'
    @curl = url + "graphql/query/?query_hash=#{user_hash}&variables=%7B%22id%22%3A%#{node_id}%22%2C%22first%22%3A10%2C%22after%22%3A%22#{next_page_key}%22%7D"
    @categories = node.categories
    visit_page

  end
end

# Next Page CURL Requests
user_hash = '37479f2b8209594dde7facb0d904896a'
node_id = '22248701561'
next_page_key = 'AQAlaD0DYLXEYBbO8WS7L79E7B3WuYCLM7mSine_FHhgHovWZHxOvUfZNDuLzYukRkck5rxilLVHJBMBD-OVsuFPS803XMIYWlv43p4pe2vTkw'


headers = {
  cookie: 'mid=Ws0fdQAEAAE_6hqPgXqy1N-MrWYE; ig_pr=1; ig_vh=911; csrftoken=YR5rAUnAzW0PnQZfc4rUkWcIk2vIHrwe; ds_user_id=7438696022; sessionid=IGSCc6edd668b70b8d94b3c629686f98f6e1f9375d2de58f0ac66ae92b1426d6b5cb%3Ak1seFZTiRY55v9y050hjtfBDKM52udi4%3A%7B%22_auth_user_id%22%3A7438696022%2C%22_auth_user_backend%22%3A%22accounts.backends.CaseInsensitiveModelBackend%22%2C%22_auth_user_hash%22%3A%22%22%2C%22_platform%22%3A4%2C%22_token_ver%22%3A2%2C%22_token%22%3A%227438696022%3ADxTF2aEvTgdfTLjNJvDHzfkOAbkwGdXQ%3A446f46337235e53387bc73c70728c529c0d3ba8deee17f54885bfc0654ed526f%22%2C%22last_refreshed%22%3A1523392386.672046423%7D; ig_or=landscape-primary; rur=FRC; ig_vw=1213; urlgen="{\"time\": 1523392388\054 \"185.210.217.141\": 9009}:1f605o:GcDLFmw-CVejWJlO59lX9GflHrQ"'
}

followers = []

counter = 0

loop do
  p "Request \##{counter += 1}"
  curl = "https://www.instagram.com/graphql/query/?query_hash=#{user_hash}&variables=%7B%22id%22%3A%#{node_id}%22%2C%22first%22%3A10%2C%22after%22%3A%22#{next_page_key}%22%7D"
  doc = HTTParty.get(curl, headers: headers)['data']['user']['edge_followed_by']

  # follow_page = doc['data']['user']['edge_followed_by']
  followers += doc['edges']

  next_page_key = doc['page_info']['end_cursor']

  break if next_page_key.nil?

  p "Next key is: #{next_page_key}"
end
