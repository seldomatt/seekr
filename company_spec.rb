require_relative 'company'

describe Company do 
  before(:each) do 
    @company = Company.new
    @company.name = "CM Retail Management, Inc."
    @company.location = "Reno, NV"
    @company.description = "Shitty Company"
  end


describe Company do 
  it "can instantiate an instance of itself" do 
    @company.should be_true
  end
end

describe Company do 
  it "has a name, location, desc, and jobs" do 
    @company.name.should == "CM Retail Management, Inc."
    @company.location.should == "Reno, NV"
    @company.description.should == "Shitty Company"
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
    company = Company.find("Kabam")
    company.name.should == "Kabam"
  end
end
end
