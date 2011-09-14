class ShiftsController < ApplicationController
  before_filter :login_required, :find_user, :authorize      

  # GET /shifts
  # GET /shifts.xml
  def index
    #@shifts = Shift.find(:all, :conditions => ['user_id = ?', @user.id])
    @shifts = @user.shifts
    @shift_months = @shifts.group_by { |t| t.start.beginning_of_month }
    @shift = Shift.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shifts }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.xml
  def show
    @shift = Shift.find_by_id(params[:id])
    #@payroles = Payrole.find(:all, :conditions => ['shift_id = ?', @shift.id])
    @payroles = @shift.payroles
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shift }
    end
  end

  # GET /shifts/new
  # GET /shifts/new.xml
  def new
    if Shift.pay(@user.id).empty?
      redirect_to new_user_pay_path(@user)
    elsif Shift.place(@user.id).empty?
      redirect_to new_user_place_path(@user)
    else
      @shift = Shift.new
        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @shift }
        end
      end

  end

  # GET /shifts/1/edit
  def edit
    @shift = Shift.find_by_id(params[:id])
  end

  # POST /shifts
  # POST /shifts.xml
  def create    
    @shift = @user.shifts.build(params[:shift])
    
    respond_to do |format|
      if @shift.save
        flash[:notice] = t('shift.created')
        format.html { redirect_to(user_shift_path(@user, @shift)) }
        format.xml  { render :xml => @shift, :status => :created, :location => @shift }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shifts/1
  # PUT /shifts/1.xml
  def update
    @shift = Shift.find_by_id(params[:id])

    respond_to do |format|
      if @shift.update_attributes(params[:shift])
        flash[:notice] = t('shift.updated')
        format.html { redirect_to(user_shift_path(@user, @shift)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.xml
  def destroy
    @shift = Shift.find_by_id(params[:id])
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to(user_shifts_path(@user)) }
      format.xml  { head :ok }
    end
  end

  def toggle_active

    @shift = Shift.find(params[:id])

    @shift.toggle :active

    @shift.save

    refere = request.env['HTTP_REFERER'].downcase
    if refere.include? "shifts"
      @shifts = @user.shifts
    else
      @shifts = @user.shifts.find(:all, :conditions => ['active = ?', 1])
    end


    @shift_months = @shifts.group_by { |t| t.start.beginning_of_month }
    render :layout =>false

  end


end
