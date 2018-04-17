class RemoveJsonDataFromInfluencers < ActiveRecord::Migration[5.1]
  def change
    remove_column :influencers, :json_data
  end
end
