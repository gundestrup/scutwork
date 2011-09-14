class BuildersController < ApplicationController
  before_filter :login_required, :find_user

  def shift
    if !params[:mold].present?
      flash[:error] = t('error.cant_access_information')
      redirect_to('/')
    else

      @vars = params[:mold]
      @mold = Mold.find_by_id(@vars["mold_id"])
      if @mold.user_id = current_user.id or current_user.admin
        @shift = Shift.new
        @shift.start = @vars["start"].to_time+@mold.start_time.hour*60*60+@mold.start_time.min*60
        @shift.end = @shift.start+(@mold.duration_hours+@mold.duration_minutes)
        @shift.place_id = @mold.place_id
        @shift.user_id = @mold.user_id

        respond_to do |format|
          if @shift.save
            for pay in @mold.paymasters
              payrole(@shift.id, pay.pay_id, pay.hours)
            end
            flash[:notice] = t('builder.shift_created')
            format.html { redirect_to(user_path(@shift.user_id)) }
            format.xml  { render :xml => @shift, :status => :created, :location => @shift }
          else
            flash[:error] = t('builder.shift_created_error')
            format.html { redirect_to(user_path(@shift.user_id)) }
            format.xml  { render :xml => @shift.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:error] = t('error.cant_access_others_information')
        redirect_to('/')
      end
    end    
  end

  def pay_kbu
    @user = User.find_by_id(params[:user_id])
    if @user.id == current_user.id or current_user.admin
      pay_builder("Honorar pr. udetjeneste", 74939, "pr gang")
      pay_builder("Holddrift lille", 5476, "hverdage 20-08 og i weekender 8-20")
      pay_builder("Holddrift stor", 9174, "weekender 20-08, søgnehelligdage, Mandage og dage efter søgnehelligdage kl. 00-08")
      pay_builder("Manglende varsel ved ekstraordinært tilkald<br/> på en fridag", 173523, "N/A")
      pay_builder("Manglende varsel ved ekstraordinært tilkald<br/> i forlængelse af planlagt tjeneste", 86762, "N/A")
      pay_builder("Overarbejde pr. time", 27107, "N/A")
      pay_builder("Vagt uden for tjenestestedet pr. time	", 6024, "N/A")
      
      pay_builder("Normal timeløn",18071,"28.643,25kr/mdr <br/>4,3332uger/mdr<br/> 37timer/uge =")

      respond_to do |format|
            flash[:notice] = t('pay.created')
            format.html { redirect_to(user_pays_path(@user)) }
        end
    else
        flash[:error] = t('error.cant_access_others_information')
        redirect_to('/')
    end
  end

  protected

  def payrole(shift_id, pay_id, hours)
    @payrole = Payrole.new
    @payrole.shift_id = shift_id
    @payrole.pay_id = pay_id
    @payrole.hours = hours
    @payrole.save
  end

  def pay_builder(name,rate,description)
    @pay = Pay.new
    @pay.user_id = @user.id
    @pay.active = true
    @pay.name = name
    @pay.rate = rate
    @pay.start_date = DateTime.now
    @pay.end_date =DateTime.now + 1.year
    @pay.description = description
    @pay.save
    flash[:notice] = t('pay.created')
  end

end
