class CreateMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :mailings do |t|
      t.string :content
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
