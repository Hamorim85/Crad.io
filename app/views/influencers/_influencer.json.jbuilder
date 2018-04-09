json.extract! influencer, :id, :username, :email, :country, :followers_count, :following_count, :bio, :media_count, :igid, :photo, :full_name, :verified, :external_url, :created_at, :updated_at
json.url influencer_url(influencer, format: :json)
