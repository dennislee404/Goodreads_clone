class Review < ActiveRecord::Base
	belongs_to :book, required: true
	belongs_to :user, required: true

	validates_presence_of :user
	validates_presence_of :content
	
	validates :score, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 1,
		less_than_or_equal_to: 5
	}
end