class NodeCategory < ApplicationRecord
  belongs_to :category
  belongs_to :node
end
