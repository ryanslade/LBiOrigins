class GoogleMaps
  include HTTParty
  
  #base_uri "maps.google.com"
  
  # Given an address will return a hash with :lat and :lng as keys, otherwise nil
  def self.geocode(address)
    result = get("http://maps.google.com/maps/api/geocode/json?sensor=false", :query => {:address => address })
    if result.parsed_response["results"].length > 0
      return { :lat => result.parsed_response["results"][0]["geometry"]["location"]["lat"].to_f,
               :lng => result.parsed_response["results"][0]["geometry"]["location"]["lng"].to_f } 
    end
    nil
  end
  
end