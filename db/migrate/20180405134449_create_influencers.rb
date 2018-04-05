class CreateInfluencers < ActiveRecord::Migration[5.1]
  def change
    create_table :influencers do |t|
      t.string :username
      t.string :email
      t.string :country
      t.integer :followers_count
      t.integer :following_count
      t.text :bio
      t.integer :media_count
      t.integer :igid
      t.string :photo
      t.string :full_name
      t.boolean :verified
      t.string :external_url

      t.timestamps
    end
  end
end
