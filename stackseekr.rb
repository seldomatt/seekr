require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'FileUtils'




@db = SQLite3::Database.open('stackseekr.db')

# Take user input and parse resulting web pages (get URLS for job pages)

puts "Enter a search term:"
searchterm = gets.downcase.strip.split.join("+")


puts "Where:"
location = gets.downcase.strip.split.join("+")

puts "Within how many miles:"
range = gets.strip.to_i



stackurl = "http://careers.stackoverflow.com"
indexurl = stackurl + "/jobs?searchTerm=#{searchterm}&location=#{location}&range=#{range}&pg=1"

job_links = []

is_there_a_next_page = true
page = 1
while is_there_a_next_page == true
	uri = "http://careers.stackoverflow.com/jobs?searchTerm=#{searchterm}&location=#{location}&range=#{range}&pg=#{page}"
	doc = Nokogiri::HTML(open(uri))
	this_pages_links = doc.css('a.title').map do |obj|
	"http://careers.stackoverflow.com#{obj["href"]}"
	end
	job_links.concat(this_pages_links)
	page += 1

	if this_pages_links.empty?
		is_there_a_next_page = false
	end
end


# iterates over job postings to populate database

job_links.each do |job|
	doc = Nokogiri::HTML(open(job))

	jobtitle = doc.css('a.title').text
	companyname = doc.css('a.employer').text
	location_and_terms  = doc.css('span.location').text
		if location_and_terms.include?("(")
			location = location_and_terms.split("(")[0].strip
			terms = location_and_terms.split("(")[1].delete(")")
		else 
			location = location_and_terms.strip
		end
	jobdescription = doc.css('div.description')[0].text.strip
	skills = if doc.css('div.description')[1]
										doc.css('div.description')[1].text.strip
										else
										" - "
										end
	companydescription = 	if doc.css('div.description')[2]
									doc.css('div.description')[2].text.strip
									else
									" - "
									end


	@db.execute("INSERT INTO stackjobs (jobtitle, companyname, location, terms, jobdescription, skills, companydescription) VALUES (?,?,?,?,?,?,?)", 
							jobtitle, 
							companyname, 
							location, 
							terms, 
							jobdescription,
							skills,
							companydescription)

end



class DB

def self.schema
  @db = SQLite3::Database.new( "stackseekr.db" )
  sql = <<SQL
  CREATE table stackjobs
  ( id INTEGER PRIMARY KEY, 
  jobtitle TEXT,
  companyname TEXT,
  location TEXT,
  terms TEXT,
  jobdescription TEXT,
  skills TEXT,
  companydescription TEXT
  );
SQL

@db.execute sql

@db

end

def self.drop_table
  @db = SQLite3::Database.open( "stackseekr.db")
  sql = <<SQL
  DROP table stackjobs;
SQL

@db.execute sql

end







end