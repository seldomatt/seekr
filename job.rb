class Job
	attr_accessor :title, :terms, :description, :skills
	attr_reader :company

	def company=(company)
		@company = company
		company.jobs << self
	end
	
end