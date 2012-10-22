class Company
  attr_accessor :name, :location, :description, :jobs

  def initialize
    @jobs = []
    self.class.all << self
  end

  def self.all
  	@@company ||= []
  end


end