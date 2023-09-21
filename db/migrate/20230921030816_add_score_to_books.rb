class AddScoreToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :score, :integer
  end
end
