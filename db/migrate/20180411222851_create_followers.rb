class CreateFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :followers do |t|
      t.string :username
      t.boolean :verified
      t.boolean :approved
      t.string :followers_count
      t.datetime :parsed_at

      t.timestamps
    end
  end
end
