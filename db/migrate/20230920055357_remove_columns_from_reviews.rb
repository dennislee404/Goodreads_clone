class RemoveColumnsFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :user, :string
  end
end
