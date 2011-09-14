class PaysController < ApplicationController
  before_filter :login_required, :find_user, :authorize


  # GET /pays
  # GET /pays.xml

  def index
    @pays = @user.pays

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pays }
    end
  end

  # GET /pays/1
  # GET /pays/1.xml
  def show
    @pay = Pay.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pay }
    end
  end

  # GET /pays/new
  # GET /pays/new.xml
  def new
    @pay = Pay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pay }
    end
  end

  # GET /pays/1/edit
  def edit
    @pay = Pay.find_by_id(params[:id])
  end

  # POST /pays
  # POST /pays.xml
  def create
    @pay = @user.pays.build(params[:pay])
    respond_to do |format|
      if @pay.save
        flash[:notice] = t('pay.created')
        format.html { redirect_to user_pays_path(@user) }
        format.xml  { render :xml => @pay, :status => :created, :location => @pay }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pay.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pays/1
  # PUT /pays/1.xml
  def update
    @pay = Pay.find_by_id(params[:id])

    respond_to do |format|
      if @pay.update_attributes(params[:pay])
        flash[:notice] = t('pay.updated')
        format.html { redirect_to user_pays_path(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pay.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pays/1
  # DELETE /pays/1.xml
  def destroy
    @pay = Pay.find_by_id(params[:id])
    @pay.destroy

    respond_to do |format|
      format.html { redirect_to user_pays_path(@user) }
      format.xml  { head :ok }
    end
  end
  
end
