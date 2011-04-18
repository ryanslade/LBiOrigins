class MapController < ApplicationController
  
  def index
    @people = Person.all
    @person = Person.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end
