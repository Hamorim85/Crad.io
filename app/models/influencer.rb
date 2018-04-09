class Influencer < ApplicationRecord
  has_many :categories, through: :influencer_categories
  has_many :influencer_categories
  validates :username, :followers_count, :following_count, presence: :true
  validates :username, uniqueness: :true
  def follow_ratio
    self.followers_count / self.following_count.to_f
  end
end
