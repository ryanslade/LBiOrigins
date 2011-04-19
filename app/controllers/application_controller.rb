class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ADMIN_USER = "admin"
  ADMIN_PASSWORD = "Or1g1ns"
  
  private
  
  def check_is_admin
    
    authenticate_or_request_with_http_basic do |id, password| 
      (id == ADMIN_USER && password == ADMIN_PASSWORD)
    end
    
  end
end
