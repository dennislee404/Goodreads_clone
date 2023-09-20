require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/book'
require_relative 'models/review'


get '/login' do 
	erb :login
end

get '/' do 
	erb :index
end

post '/add-book' do
	@book = Book.create(title: params[:title], author: params[:author])

	if @book.save
		erb :book
	else
		erb :index
	end
end

get '/books/:id' do 
	@book = Book.find(params[:id])
	@reviews = Review.where(book_id: params[:id])
	
	erb :book
end

get '/books' do
	@books = Book.all.order(created_at: :asc)
	erb :books
end

post '/edit-book/:id' do
	@book = Book.find(params[:id])
	erb :edit_book
end

post '/update-book/:id' do 
	@book = Book.find(params[:id])
	@book.update(title: params[:title], author: params[:author], description: params[:description])

	erb :book
end

post '/delete-book/:id' do
	@book = Book.find(params[:id])

	if @book.destroy
		redirect '/books'
	else
		redirect '/'
	end
end

post '/review-book/:id' do
	@book = Book.find(params[:id])

	erb :review_book
end

post '/update-review-book/:id' do
	@book = Book.find(params[:id])
	@book.reviews.create(user: params[:user], score: params[:score], content: params[:content])

	erb :book
end