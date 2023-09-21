require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'

require 'carrierwave'
require 'carrierwave/orm/activerecord'

require_relative 'models/book'
require_relative 'models/review'
require_relative 'models/user'

enable :sessions

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end

get '/login' do
	if current_user
		redirect '/books'
	else 
		erb :login
	end
end

post '/login' do 
	@user = User.find_by(username: params[:username])

	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/books'
	else
		redirect '/login'	
	end
end

post '/logout' do 
	session[:user_id] = nil
	redirect '/login'
end

get '/register' do 
	erb :register
end

post '/register' do 
	@user = User.create(
		username: params[:username],
		password: params[:password],
		password_confirmation: params[:password_confirmation]
		)

	if @user.save
		redirect '/login'
	else
		redirect '/register'
	end
end

get '/profile' do 
	if current_user == nil
		redirect '/login'
	else
		erb :profile
	end
end

post '/update-profile-pic' do 
	current_user.update(user_photo: params[:photo])

	redirect '/books'
end

get '/add-book' do
	if current_user == nil
		redirect '/login'
	else
		erb :add_book
	end
end

post '/add-book' do
	@book = current_user.books.create(title: params[:title], author: params[:author])
	@reviews = Review.where(book_id: @book.id) 

	if @book.save
		erb :book
	else
		erb :add_book
	end
end

get '/books/:id' do 
	@book = Book.find(params[:id])
	@reviews = Review.where(book_id: params[:id])
	
	erb :book
end

get '/books' do
	if current_user == nil
		redirect '/all-books'
	else	
		@books = Book.where(user_id: session[:user_id]).order(created_at: :asc)
		erb :books
	end
end

post '/edit-book/:id' do
	@book = Book.find(params[:id])
	erb :edit_book
end

post '/update-book/:id' do 
	@book = Book.find(params[:id])
	@book.update(title: params[:title], author: params[:author], description: params[:description])
	@reviews = Review.where(book_id: params[:id])

	erb :book
end

post '/delete-book/:id' do
	@book = Book.find(params[:id])

	if @book.destroy
		redirect '/books'
	else
		redirect '/book'
	end
end

post '/review-book/:id' do
	@book = Book.find(params[:id])

	if current_user == nil
		redirect '/login'
	else
		erb :review_book
	end
end

post '/update-review-book/:id' do

	@review = current_user.reviews.create(score: params[:score], content: params[:content], book_id: params[:id])

	@book = Book.find(params[:id])
	@reviews = Review.where(book_id: params[:id])
	# @book = Book.find(params[:id])
	# @book.reviews.create(user_id: params[:user], score: params[:score], content: params[:content])

	if @review.save
		redirect "/books/#{@book.id}"
	else
		erb :review_book
	end
end

get '/all-books' do 
	@books = Book.all.order(score: :desc)
	puts current_user

	erb :all_books
end