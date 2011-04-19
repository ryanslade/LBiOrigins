class MapController < ApplicationController
  
  # GET /map
  def index
    @person = Person.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def people
     @people = Person.all

      respond_to do |format|
        format.json  { render :json => @people.to_json(:include => :department) }
      end
  end
  
end
