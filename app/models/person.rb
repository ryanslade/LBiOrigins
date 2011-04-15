class Person < ActiveRecord::Base
  
  validates_presence_of :first_name, :last_name, :home_town, :home_country
  
  before_create :geocode

  protected
  
  def geocode
    raise "Geocoding stuff to go here"
  end
  
end
