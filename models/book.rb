class Book < ActiveRecord::Base
	has_many :reviews
	belongs_to :user, required: true
	
	validates_presence_of :title
	validates_presence_of :author
	validates :description, length: { maximum: 300 }
end