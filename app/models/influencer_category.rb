# frozen_string_literal: true

# app/models/influencer_category.rb
class InfluencerCategory < ApplicationRecord
  belongs_to :category
  belongs_to :influencer
  belongs_to :node

  validates :node, uniqueness: { scope: %i[category influencer] }
  validates :category, :node, :influencer, presence: true
end
