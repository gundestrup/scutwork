class MoldsController < ApplicationController
  before_filter :login_required, :find_user, :authorize

  # GET /molds
  # GET /molds.xml
  def index
    @molds = @user.molds.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @molds }
    end
  end

  # GET /molds/1
  # GET /molds/1.xml
  def show
    @mold = @user.molds.find_by_id(params[:id])
    @paymaster = Paymaster.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mold }
    end
  end

  # GET /molds/new
  # GET /molds/new.xml
  def new
    @mold = Mold.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mold }
    end
  end

  # GET /molds/1/edit
  def edit
    @mold = @user.molds.find_by_id(params[:id])
  end

  # POST /molds
  # POST /molds.xml
  def create
    @mold = @user.molds.build(params[:mold])

    respond_to do |format|
      if @mold.save
        flash[:notice] = t('mold.created')
        format.html { redirect_to(user_mold_url(@user, @mold)) }
        format.xml  { render :xml => @mold, :status => :created, :location => @mold }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mold.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /molds/1
  # PUT /molds/1.xml
  def update
    @mold = @user.molds.find_by_id(params[:id])

    respond_to do |format|
      if @mold.update_attributes(params[:mold])
        flash[:notice] = t('mold.updated')
        format.html { redirect_to(user_mold_url(@user, @mold)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mold.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /molds/1
  # DELETE /molds/1.xml
  def destroy
    @mold = @user.molds.find_by_id(params[:id])
    @mold.destroy

    respond_to do |format|
      format.html { redirect_to(user_molds_path(@user)) }
      format.xml  { head :ok }
    end
  end

end
