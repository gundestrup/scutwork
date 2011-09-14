class PayrolesController < ApplicationController
  before_filter :login_required, :find_user, :find_shift, :authorize  

  # GET /payroles
  # GET /payroles.xml
  #def index
  #  @payroles = Payrole.find(:all, :conditions => ['shifts.user_id = ?', @user.id], :include => [:shift, {:shift => :user}])
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @payroles }
  #  end
  #end

  # GET /payroles/1
  # GET /payroles/1.xml
  #def show
  #  @payrole = Payrole.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @payrole }
  #  end
  #end

  # GET /payroles/new
  # GET /payroles/new.xml
  def new
    @payrole = Payrole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payrole }
    end
  end

  # GET /payroles/1/edit
  def edit
    @payrole = Payrole.find_by_id(params[:id])
  end

  # POST /payroles
  # POST /payroles.xml
  def create
    #@payrole = Payrole.new(params[:payrole])
    @payrole = @shift.payroles.build(params[:payrole])

    respond_to do |format|
      if @payrole.save
        flash[:notice] = t('payrole.created')
        format.html { redirect_to user_shift_path(@user, @shift) }
        format.xml  { render :xml => @payrole, :status => :created, :location => @payrole }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payrole.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payroles/1
  # PUT /payroles/1.xml
  def update
    @payrole = Payrole.find_by_id(params[:id])

    respond_to do |format|
      if @payrole.update_attributes(params[:payrole])
        flash[:notice] = t('payrole.updated')
        format.html { redirect_to user_shift_path(@user, @shift) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payrole.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payroles/1
  # DELETE /payroles/1.xml
  def destroy
    @payrole = Payrole.find_by_id(params[:id])
    @payrole.destroy

    respond_to do |format|
      format.html { redirect_to user_shift_path(@user, @shift) }
      format.xml  { head :ok }
    end
  end

protected

  def find_shift
   @shift = Shift.find_by_id(params[:shift_id])
  end

end
