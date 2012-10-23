require_relative 'company'

describe Company do 
  before(:each) do 
    @company = Company.new
    @company.companyname = "CM Retail Management, Inc."
    @company.location = "Reno, NV"
    @company.companydescription = "Shitty Company"
  end


describe Company do 
  it "can instantiate an instance of itself" do 
    @company.should be_true
  end
end

describe Company do 
  it "has a name, location, desc, and jobs" do 
    @company.companyname.should == "CM Retail Management, Inc."
    @company.location.should == "Reno, NV"
    @company.companydescription.should == "Shitty Company"
  end
end

describe Company do 
  it "is instantiated with an empty jobs array" do 
    @company.jobs.should == []
  end
end

describe Company do
  it "should be able to retrieve all the companies" do
    Company.all.should include(@company)
  end
end

describe Company do 
  it "should be able to find a company from the db" do 
    company = Company.find("ThoughtWorks")
    company.companyname.should == "ThoughtWorks"
  end
end

describe Company do 
  it "should be able to find a companies jobs" do 
    jobs = Company.find_jobs("ThoughtWorks")
    job = jobs.select {|j| j.jobtitle == "seeking bright, passionate, principal developers"}.first
    job.should be_true
  end
end
end
