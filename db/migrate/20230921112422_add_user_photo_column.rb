class AddUserPhotoColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_photo, :string, default: '/images/blank-profile-pic.png'
  end
end
