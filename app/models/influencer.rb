class Influencer < ApplicationRecord
  belongs_to :follower, optional: true # Temporary solution
  has_many :influencer_categories, dependent: :destroy
  has_many :categories, through: :influencer_categories
  validates :username, uniqueness: true
  validates :username, :followers_count, :following_count,
            :ig_pic_url, presence: true

  def follow_ratio
    followers_count / following_count.to_f
  end

  def name
    full_name.empty? ? username : full_name
  end

  def ig_followers
    return "#{(followers_count / 1_000_000.0).round(1)}m" if followers_count > 999_999
    return "#{(followers_count / 1_000.0).round(1)}k" if followers_count > 999
    followers_count
  end

  def ig_following
    return "#{(following_count / 1_000_000.0).round(1)}m" if following_count > 999_999
    return "#{(following_count / 1_000.0).round(1)}k" if following_count > 999
    following_count
  end

  def self.search(params)
    search_result = order(followers_count: :DESC)
    search_result = search_result.joins(:categories).where(categories: {id: params[:categories]}).distinct if params[:categories].present?
    search_result = search_result.where("following_count > ?", params[:following_count].to_i) if params[:following_count].present?
    search_result = search_result.where("followers_count > ?", params[:followers_count].to_i) if params[:followers_count].present?
    search_result
  end
end
