class ChangeScoreFromIntegerToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :score, :float
  end
end
