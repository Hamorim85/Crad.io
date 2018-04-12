class ChangeVefifiedDefaultsFromInfluencers < ActiveRecord::Migration[5.1]
  def change
    change_column :influencers, :verified, :boolean, null: false, default: false
  end
end
