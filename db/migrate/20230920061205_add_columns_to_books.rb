class AddColumnsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :user_id, :integer
    add_column :books, :genre, :string    
  end
end
