class Job
	attr_accessor :title, :terms, :description, :skills
	attr_reader :company

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
    self.all.select {|j| j.title == jobtitle}
  end
	
end