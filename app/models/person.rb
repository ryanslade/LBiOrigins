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
    
    if result
      self.latitude, self.longitude = result[:lat], result[:lng]
      
      # If another user has the same location, randomise by a small amount
      # so their pin's dont cover each other
      if (Person.where(:latitude => self.latitude, :longitude => self.longitude).count > 0)
        self.latitude  += (rand(150)-100).to_f/10000
        self.longitude += (rand(150)-100).to_f/10000
      end

    end
    
  end
  
end
