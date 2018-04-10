class Influencer < ApplicationRecord
  has_many :influencer_categories
  has_many :categories, through: :influencer_categories
  validates :username, presence: true, uniqueness: true

  def follow_ratio
    self.followers_count / self.following_count.to_f
  end
end
