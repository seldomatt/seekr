require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# Create the database

db = SQLite3::Database.new("stackseekr.db")
sql = <<SQL
CREATE table stackjobs
(





	);
SQL

db.execute_batch( sql )

# Take user input and parse resulting web pages (get URLS for job pages)

puts "Enter a search term:"
searchterm = gets.downcase.strip

puts "Where:"
location = gets.downcase.strip

puts "Within how may miles:"
range = gets.downcase.strip

indexurl = "http"

