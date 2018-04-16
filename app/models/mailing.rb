class Mailing < ApplicationRecord

  attr_accessor :influencers_array

  belongs_to :brand
  has_many :influencer_mails
  has_many :influencers, through: :influencer_mails
end
