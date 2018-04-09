class AddJsonDataToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :json_data, :string
  end
end
