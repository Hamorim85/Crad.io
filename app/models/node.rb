class Node < ApplicationRecord
  has_many :categories, through: :node_categories
  has_many :node_categories
  validates :name, uniqueness: :true, presence: true
end
