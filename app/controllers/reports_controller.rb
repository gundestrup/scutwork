class ReportsController < ApplicationController
    before_filter :login_required
    before_filter :find_user
    before_filter :authorize


  def index

  end

    #Currently disabled TODO: Fix the function, or change it!
  #def week
  #  if !params[:report].present?
  #        flash[:error] = t('error.cant_access_information')
  #        redirect_to('/')
  #  else
  #
  #        @shifts = @user.shifts.by_week(params[:report][:week].to_date.strftime('%W').to_i, :field => :start, :year => params[:report][:week].to_date.strftime('%Y').to_i)
  #        @shift_places = @shifts.group_by{ |t| t.place.name }
  #    end
  #
  #end

  def month
    if !params[:date].present?
      flash[:error] = t('error.cant_access_information')
      redirect_to('/')
    else
      @shifts = @user.shifts.by_month(params[:date][:month].to_i, :field => :start, :year => params[:date][:year].to_i)#, :include  => [:payroles, {:payroles => :pay}], :order => "pays.name DESC")
      @shift_dates = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, 1)
      @shift_places = @shifts.group_by{ |t| t.place.name }

    end
  end

  def year
    if !params[:date].present?
            flash[:error] = t('error.cant_access_information')
            redirect_to('/')
          else
            @shifts = @user.shifts.by_year(params[:date][:year].to_i, :field => :start)#, :include  => [:payroles, {:payroles => :pay}], :order => "pays.name DESC")
            @shift_places = @shifts.group_by{ |t| t.place.name }
            @shift_dates = params[:date][:year].to_i 
    end

  end

  def norm
    if !params[:date].present?
            flash[:error] = t('error.cant_access_information')
            redirect_to('/')
    else

      @start = params[:date][:start].to_date
      @normduration = params[:date][:normduration].to_i
      @enddate = @start+(@normduration*7)
            @shifts = @user.shifts.between(@start, @enddate, :field => :start)
            @shift_places = @shifts.group_by{ |t| t.place.name }

    end

  end



  private

  #def find_user
  #   @user = User.find_by_id(current_user.id)
  #end

end
