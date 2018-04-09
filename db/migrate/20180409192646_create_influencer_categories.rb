class CreateInfluencerCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :influencer_categories do |t|
      t.references :category, foreign_key: true
      t.references :influencer, foreign_key: true

      t.timestamps
    end
  end
end
