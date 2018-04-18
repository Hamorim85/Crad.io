class Category < ApplicationRecord

  has_many :influencer_categories
  has_many :influencers, through: :influencer_categories

  has_many :node_categories
  has_many :nodes, through: :node_categories

  validates :name, uniqueness: true, presence: true
end
