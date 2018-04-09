class ChangeIntegerToStringOnInfluencers < ActiveRecord::Migration[5.1]
  def change
    change_column :influencers, :igid, :string
  end
end
