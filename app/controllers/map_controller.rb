class MapController < ApplicationController
  
  # GET /map
  def index
    @person = Person.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end
