class AddIgPicUrlToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :ig_pic_url, :string
  end
end
