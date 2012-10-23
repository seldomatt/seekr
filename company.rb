# require_relative 'stackseekr'
require 'sqlite3'

class Company 

  CompanyAttributes = ["name", "location", "description", "jobs"]

  CompanyAttributes.each do |att|
    attr_accessor att.to_sym
  end

  def initialize
    @jobs = []
    self.class.all << self
  end

  def self.all
  	@@company ||= []
  end

  def self.find(companyname)
    company = Company.new
    db = SQLite3::Database.open( "stackseekr.db" )
    db.results_as_hash = true
    result = db.execute("SELECT * FROM stackjobs WHERE companyname = '#{companyname}'")[0]
    result.each do |k,v|
    company.send("#{k}=", v) if CompanyAttributes.include?(k)
    end
    company
  end

  def self.find_jobs(companyname)
    db = SQLite3::Database.open( "stackseekr.db" )
    db.results_as_hash = true
    result = db.execute("SELECT ")
  end



  

  


end