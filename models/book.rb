class Book < ActiveRecord::Base
	has_many :reviews
	
	validates_presence_of :title
	validates_presence_of :author
	validates :description, length: { maximum: 30 }
end