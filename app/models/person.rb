class Person < ActiveRecord::Base
  
  belongs_to :department
  
  validates_presence_of :first_name, :last_name, :home_town, :home_country, :latitude, :longitude, :department_id
  
  before_validation :geocode_if_neccesary

  protected
  
  def geocode_if_neccesary
    geocode if self.latitude.nil? && self.longitude.nil?
  end
  
  def geocode
    address = "#{home_town}, #{home_country}"
    result = GoogleMaps.geocode(address)
    self.latitude, self.longitude = result[:lat], result[:lng] if result
  end
  
end
