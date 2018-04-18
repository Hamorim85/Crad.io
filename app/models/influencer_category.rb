# frozen_string_literal: true

# app/models/influencer_category.rb
class InfluencerCategory < ApplicationRecord
  belongs_to :category
  belongs_to :influencer
  belongs_to :node
end
