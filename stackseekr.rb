require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# Create the database

db = SQLite3::Database.new( "stackseekr.db" )
sql = <<SQL
CREATE table stackjobs
( id INTEGER PRIMARY KEY, 
job_title TEXT,
company TEXT,
location TEXT,
location_terms TEXT,
tags TEXT,
description TEXT,
skills_and_reqs TEXT,
company_desc TEXT
);
SQL

db.execute_batch( sql )

# Take user input and parse resulting web pages (get URLS for job pages)

# def format_userinput(input)
# 	downcase.strip.split.join("+")
# end

puts "Enter a search term:"
searchterm = gets.downcase.strip.split.join("+")


puts "Where:"
location = gets.downcase.strip.split.join("+")

puts "Within how may miles:"
range = gets.strip.to_i

stackurl = "http://careers.stackoverflow.com"
indexurl = stackurl + "/jobs?searchTerm=#{searchterm}&location=#{location}&range=#{range}"



page_links = []

doc = Nokogiri::HTML(open(indexurl))
doc.css("div.pagination a").map do |pagelink|
	page_links << stackurl + pagelink["href"]
end

page_links = page_links.uniq!

puts page_links.inspect

# page_links.each do |page|
# 	doc = Nokogiri::HTML(open(page))
# 	doc.







