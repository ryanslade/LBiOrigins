class Department < ActiveRecord::Base
  
  has_many :people
  
  validates_presence_of :name
  
  def self.dropdown_options(default_text = "Please Select")
    [[default_text, nil]] + self.order(:name).select("name, id").collect { |d| [d.name, d.id] }
  end
  
end
