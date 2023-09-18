require 'sinatra'
require 'sinatra/activerecord'

require_relative 'models/book'

get '/login' do 
	erb :login
end

get '/' do 
	erb :index, layout: false
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
	erb :book
end

get '/books' do
	@books = Book.all
	erb :books
end