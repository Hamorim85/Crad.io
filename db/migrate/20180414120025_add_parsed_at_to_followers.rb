class AddParsedAtToFollowers < ActiveRecord::Migration[5.1]
  def change
    add_column :followers, :parsed_at, :datetime
  end
end
