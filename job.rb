class Job
	attr_reader :company

  JobAttributes = ["title", "terms", "description", "skills"]

  JobAttributes.each do |att|
    attr_accessor att.to_sym
  end

	def initialize
    self.class.all << self
  end

  def company=(company)
		@company = company
		company.jobs << self
	end

  def self.all
    @@jobs ||= [] 
  end

  def self.find(jobtitle)
    job = Job.new
    db = SQLite3::Database.open( "stackseekr.db" )
    db.results_as_hash = true
    result = db.execute("SELECT * FROM stackjobs WHERE jobtitle = '#{jobtitle}'")[0]
    result.each do |k,v|
      job.send("#{k}=", v) if JobAttributes.include?(k)
    end
    job
  end
end




# def save(object)
#   self.execute("INSERT INTO tablename (")
#     object.title, 
#     object.company.name, 
#     object.location

# end
