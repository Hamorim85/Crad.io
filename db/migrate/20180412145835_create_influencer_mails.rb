class CreateInfluencerMails < ActiveRecord::Migration[5.1]
  def change
    create_table :influencer_mails do |t|
      t.references :influencer, foreign_key: true
      t.references :mailing, foreign_key: true

      t.timestamps
    end
  end
end
