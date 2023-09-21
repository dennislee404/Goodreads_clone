class AddColumnsToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :recommended, :boolean
  end
end
