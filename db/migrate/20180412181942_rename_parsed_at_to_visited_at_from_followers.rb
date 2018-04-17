class RenameParsedAtToVisitedAtFromFollowers < ActiveRecord::Migration[5.1]
  def change
    rename_column :followers, :parsed_at, :visited_at
  end
end
