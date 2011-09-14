class PaymastersController < ApplicationController
  before_filter :login_required, :find_user, :authorize, :find_mold

  # GET /paymasters/new
  # GET /paymasters/new.xml
  def new
    @paymaster = Paymaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paymaster }
    end
  end

  # GET /paymasters/1/edit
  def edit
    @paymaster = Paymaster.find_by_id(params[:id])
  end

  # POST /paymasters
  # POST /paymasters.xml
  def create
    @paymaster = @mold.paymasters.build(params[:paymaster])    

    respond_to do |format|
      if @paymaster.save
        flash[:notice] = t('paymaster.created')
        format.html { redirect_to(user_mold_path(@user, @mold) ) }
        format.xml  { render :xml => @paymaster, :status => :created, :location => @paymaster }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paymaster.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paymasters/1
  # PUT /paymasters/1.xml
  def update
    @paymaster = Paymaster.find_by_id(params[:id])

    respond_to do |format|
      if @paymaster.update_attributes(params[:paymaster])
        flash[:notice] = t('paymaster.updated')
        format.html { redirect_to(user_mold_path(@user, @mold) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paymaster.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paymasters/1
  # DELETE /paymasters/1.xml
  def destroy
    @paymaster = Paymaster.find_by_id(params[:id])
    @paymaster.destroy

    respond_to do |format|
      format.html { redirect_to(user_mold_path(@user, @mold) ) }
      format.xml  { head :ok }
    end
  end

  protected

  def find_mold
   @mold = Mold.find_by_id(params[:mold_id])
  end
end
