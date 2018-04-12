class ChangeVefifiedAndApprovedDefaultsFromFollowers < ActiveRecord::Migration[5.1]
  def change
    change_column :followers, :verified, :boolean, null: false, default: false
    change_column :followers, :approved, :boolean, null: false, default: false
  end
end
