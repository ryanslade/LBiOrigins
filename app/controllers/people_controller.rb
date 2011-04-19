class PeopleController < ApplicationController
  before_filter :check_is_admin, :except => [:create]
  
  respond_to :html, :js, :json
  
  # GET /people
  # GET /people.xml
  def index
    @people = Person.order("last_name, first_name")

    respond_with(@people)
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_with(@person)
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_with(@person)
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    flash[:notice] = "Comment successfully created" if @person.save
    respond_with(@person, :layout => !request.xhr?)
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.json  { head :ok }
    end
  end
  
end
