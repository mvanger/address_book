# use this code to create an address book in sinatra
# create an input form
# add a person
# list people
require 'rubygems'
require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# puts "Hey gurl"

get '/' do
  @contacts = []
  db = PG.connect(:dbname => 'address_book',
    :host => 'localhost')
  sql = "select first, last, age, phone from contacts"
    db.exec(sql) do |result|
      result.each do |row|
         @contacts << row
      end
    end
  db.close
  erb :index
end

post '/' do
  @first = params[:first]
  @last = params[:last]
  @age = params[:age]
  @phone = params[:phone]
  erb :index


# get all the inputs
# put them in the string
# make it work

# this establishes a connection to the database
# db = PG.connect(:dbname => 'address_book',
#   :host => 'localhost')
# executing sql code
# passing a string of sql to the database

# insert into database
db = PG.connect(:dbname => 'address_book',
  :host => 'localhost')

# puts "what's your name girl?"
# name = gets.chomp
sql = "insert into contacts (first, last, age, phone) values ('#{@first}','#{@last}',#{@age},'#{@phone}')"
db.exec(sql)


# db.close
db.close
end
# reads from database
# db = PG.connect(:dbname => 'address_book',
#   :host => 'localhost')
# sql = "select first, age from contacts"
# db.exec(sql) do |result|
#   result.each do |row|
#     puts row
#   end
# end
# db.close