class Influencer < ApplicationRecord
<<<<<<< HEAD
  CATEGORIES = %w[Animal\ Protection Rainforest\ Protection Vegan Social].freeze
  has_many :categories, through: :influencer_categories
=======
>>>>>>> 30d9c86196a01bb3034e65b7699c58430a9b546e
  has_many :influencer_categories
  has_many :categories, through: :influencer_categories
  validates :username, :followers_count, :following_count, presence: :true
  validates :username, uniqueness: :true
  def follow_ratio
    self.followers_count / self.following_count.to_f
  end
end
