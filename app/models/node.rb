class Node < ApplicationRecord
  has_many :follower_nodes
  has_many :followers, through: :follower_nodes
  has_many :node_categories
  has_many :categories, through: :node_categories
  validates :name, uniqueness: true, presence: true
end
