class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :followers_count

      t.timestamps
    end
  end
end
