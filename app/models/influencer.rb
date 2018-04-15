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

  def ig_followers
    followers_count
  end

  def self.search(params)
    search_result = order(followers_count: :DESC)
    search_result = search_result.joins(:categories).where(categories: {id: params[:categories]}).distinct if params[:categories].present?
    search_result = search_result.where("following_count > ?", params[:following_count].to_i) if params[:following_count].present?
    search_result = search_result.where("followers_count > ?", params[:followers_count].to_i) if params[:followers_count].present?
    search_result
  end
end
