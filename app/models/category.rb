class Category < ApplicationRecord

  has_many :influencer_categories
  has_many :influencers, through: :influencer_categories

  has_many :node_categories
  has_many :nodes, through: :node_categories

  validates :name, uniqueness: true, presence: true

  def self.names(categories)
    categories.split(',').map { |id| Category.find(id.to_i).name }.join(' and ')
  end

  def img_path(categories)
    "#{name.first(3).downcase}-badge#{categories.include?(id.to_s) ? '' : '-g'}"
  end
end
