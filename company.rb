require_relative 'stackseekr'
require 'sqlite3'

class Company
  attr_accessor :name, :location, :description, :jobs

  def initialize
    @jobs = []
    self.class.all << self
  end

  def self.all
  	@@company ||= []
  end

  def self.find(companyname)
    company = Company.new
    @db = SQLite3::Database.open( "stackseekr.db" )
    @db.results_as_hash = true
    result = @db.execute("SELECT * FROM stackjobs WHERE company = '#{companyname}'")[0]
    company.name = result["company"]
    company.location = result["location"]
    company.description = result["description"]
    # puts result.inspect
    # result.each do |k,v|
    #   next if k == "id" || k == "job_title"
    #   company.send("#{k}=", v)
    # end
    company
  end


end