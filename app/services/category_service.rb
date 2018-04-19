# frozen_string_literal: true

# app/services/category_service.rb
class CategoryService
  def self.call(scope)
    Influencer.send(scope).each do |influencer|
      influencer.follower.nodes.each do |node|
        node.categories.each do |category|
          InfluencerCategory.create(
            category: category, influencer: influencer, node: node
          )
        end
      end
    end
  end
end
