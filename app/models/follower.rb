class Follower < ApplicationRecord
  has_many :follower_nodes
  has_many :nodes, through: :follower_nodes
  has_one :influencer

  validates :username, :igid, presence: true, uniqueness: true

  def json
    JSON.parse(json_data)
  end
end
