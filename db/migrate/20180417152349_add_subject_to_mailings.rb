class AddSubjectToMailings < ActiveRecord::Migration[5.1]
  def change
    add_column :mailings, :subject, :string
  end
end
