class PlacesController < ApplicationController
  before_filter :login_required, :find_user, :authorize

  # GET /places
  # GET /places.xml
  def index
    @places = @user.places.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :layout => false }# index.js.erb
      format.xml  { render :xml => @places }
    end
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = @user.places.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find_by_id(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create    
    @place = @user.places.build(params[:place])
    respond_to do |format|
      if @place.save
        flash[:notice] = t('place.created')
        format.html { redirect_to(user_places_url) }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find_by_id(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        flash[:notice] = t('place.updated')
        format.html { redirect_to(user_places_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find_by_id(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(user_places_url) }
      format.xml  { head :ok }
    end
  end  

end
