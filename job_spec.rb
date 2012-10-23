require_relative 'job'
require_relative 'company'

describe Job do
	it "can instantiate a job" do
		job = Job.new
		job.should be_true
	end
end


describe Job do
	it "has a title, terms, description, skills" do
		job = Job.new
		job.jobtitle = "Ruby Job"
		job.terms = "relocation offered"
		job.jobdescription = "Job description: Ruby job"
		job.skills = "Requirements: 5+ years experience."
		job.jobtitle.should == "Ruby Job"
		job.terms.should == "relocation offered"
		job.jobdescription.should == "Job description: Ruby job"
		job.skills.should == "Requirements: 5+ years experience."
	end
end

describe Job do
	it "should be able to handle a nil value" do
		job = Job.new
		job.terms = nil
		job.terms.should be_nil
	end
end

describe Job do
	it "should have a company" do
		job = Job.new
		company = Company.new
		job.company = company
		job.company.should == company
	end
end

describe Job do
	it "when assigning the company attr, it is saved to the company's jobs" do
		job = Job.new
		company = Company.new
		job.company = company
		company.jobs.should include(job)
	end
end 

describe Job do 
	it "should be able to retrieve all instances of itself" do 
		job2 = Job.new
		Job.all.should include(job2)
	end
end

describe Job do 
	it "should be able to find a job" do 
		job = Job.find("Ruby (Sinatra) Developer")
		job.jobtitle.should == "Ruby (Sinatra) Developer"
	end
end













