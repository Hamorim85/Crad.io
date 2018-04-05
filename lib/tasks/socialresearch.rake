require "open-uri"
require "json"

task(:research => :environment) do
  puts "hello researcher"
  list = %W{zuck barackobama realdonaldtrump neildegrassetyson nasa kaptenandson nytimes leomessi}
  puts "searching..."

  Influencer.destroy_all

  list.each do |profile|
    research(profile)
    sleep 3
  end

end


def research(profile)
      puts profile
      url = "https://www.instagram.com/#{profile}?__a=1"
      #open the url, read it what gives you a huge string. then trough JSON.
      #your turn the huge string into a hash.
      page = JSON.parse(open(url).read)
      #create a new influencer in our database
      influencer = Influencer.new
      # define the attributes
      ig = page["graphql"]["user"]
      influencer.username = ig["username"]
      influencer.photo = ig["profile_pic_url_hd"]
      influencer.bio = ig["biography"]
      influencer.full_name = ig["full_name"]
      influencer.external_url = ig["external_url"]
      influencer.followers_count = ig["edge_followed_by"]["count"]
      influencer.following_count = ig["edge_follow"]["count"]
      influencer.media_count = ig["edge_owner_to_timeline_media"]["count"]
      influencer.igid = ig["id"]
      influencer.verified = ig["is_verified"]
      influencer.save

end
