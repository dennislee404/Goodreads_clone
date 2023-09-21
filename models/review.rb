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

	after_create :update_book_score

	def update_book_score
		average_score = book.reviews.average(:score)
		book.update_column(:score, average_score)
	end
end