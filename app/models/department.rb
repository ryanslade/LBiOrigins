class Department < ActiveRecord::Base
  
  has_many :people
  
  validates_presence_of :name
  
  def self.dropdown_options
    self.order(:name).select("name, id").collect { |d| [d.name, d.id] }
  end
  
end
