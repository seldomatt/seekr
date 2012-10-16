require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'FileUtils'



if File.exist?("stackseekr.db")
	true
else
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

end

# Take user input and parse resulting web pages (get URLS for job pages)

puts "Enter a search term:"
searchterm = gets.downcase.strip.split.join("+")


puts "Where:"
location = gets.downcase.strip.split.join("+")

puts "Within how many miles:"
range = gets.strip.to_i

stackurl = "http://careers.stackoverflow.com"
indexurl = stackurl + "/jobs?searchTerm=#{searchterm}&location=#{location}&range=#{range}"


# puts multiple page search result into array page_links

page_links = []

doc = Nokogiri::HTML(open(indexurl))
doc.css("div.pagination a").map do |pagelink|
	page_links << stackurl + pagelink["href"]
end

page_links = page_links.uniq!

# iterates over page_links array to parse links to job postings

job_links = []

page_links.each do |page|
	doc = Nokogiri::HTML(open(page))
	doc.css("a.title").map do |job|
		job_links << stackurl + job["href"]
	end
end

# iterates over job postings to populate database

job_links.each do |job|
	doc = Nokogiri::HTML(open(job))

	job_title = doc.css





