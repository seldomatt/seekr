class Job
	attr_reader :company

  JobAttributes = ["jobtitle", "terms", "jobdescription", "skills"]

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