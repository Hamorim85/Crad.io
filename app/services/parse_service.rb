# frozen_string_literal: true

# app/services/parse_service.rb
class ParseService
  def self.all_fields(influencer)
    influencer = influencer.influencer if influencer.is_a?(Follower)
    json = influencer.json

    Influencer.find_or_initialize_by(
      follower: influencer.follower
    ).update(
      igid: json['id'],
      username: json['username'],
      full_name: json['full_name'],
      bio: json['biography'],
      external_url: json['external_url'],
      followers_count: json['edge_followed_by']['count'],
      following_count: json['edge_follow']['count'],
      ig_pic_url: json['profile_pic_url_hd'],
      verified: json['is_verified']
    )
    influencer.follower.update(parsed_at: Time.now)
  end

  def self.email(influencer)
    email_regex = /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/i
    email = influencer.bio.scan(email_regex).join(', ')
    influencer.update(email: email)
    email
  end

  def self.bio_search(text)
    bio = Influencer.arel_table[:bio]
    Influencer.where(bio.matches("%#{text}%"))
  end
end
