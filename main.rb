require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rainbow'

get '/' do
  erb :main
end

get '/contacts' do
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "select * from contacts"
  @contacts = db.exec(sql)
  db.close
  erb :contacts
end

post '/contacts' do
  first = params[:first]
  last = params[:last]
  age = params[:age]
  sql = "INSERT INTO contacts (first, last, age) VALUES ('#{first}', '#{last}', #{age})"
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to '/contacts'
end

get '/contacts/new' do
  erb :form
end

get '/contacts/:name' do
  @name = params[:name]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "select * from contacts where first = '#{@name}'"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end
