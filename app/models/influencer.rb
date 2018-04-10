class Influencer < ApplicationRecord
  has_many :influencer_categories
  has_many :categories, through: :influencer_categories
  validates :username, :followers_count, :following_count, presence: :true
  validates :username, uniqueness: :true
  def follow_ratio
    self.followers_count / self.following_count.to_f
  end

  def self.search(params)
    search_result = self

    search_result = search_result.joins(:categories).where(categories: {id: params[:categories]}) if params[:categories].present?
    search_result = search_result.where("following_count < ?", params[:following_count].to_i) if params[:following_count].present?
    search_result = search_result.where("followers_count < ?", params[:followers_count].to_i) if params[:followers_count].present?

    search_result
  end
end
