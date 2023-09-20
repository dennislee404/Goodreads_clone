class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :user
      t.text :content
      t.integer :book_id
      t.integer :score
      t.timestamps
    end
  end
end
