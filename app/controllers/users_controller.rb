class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :activate, :forgot, :reset]
  before_filter :find_user, :except => [:new, :create, :activate, :forgot, :reset]
  before_filter :authorize, :except => [:new, :create, :activate, :forgot, :reset]


  def index
    if admin?
      @users = User.find(:all)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @users }
      end
    else
      flash[:error] = t('error.cant_access_others_information')    
      redirect_to user_path(current_user)
    end

  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_id(params[:id])     
    if @user.nil?
        redirect_back_or_default('/')
    else
      @shifts = @user.shifts.find(:all, :conditions => ['active = ?', 1])
      @shift_months = @shifts.group_by { |t| t.start.beginning_of_month }

        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @user }
        end
    end

  end

  # render new.html.erb
  def new
    if $config.sign_up?
      @user = User.new
    elsif logged_in? && current_user.admin?
      flash[:error] = t('error.signup_disabled')
      redirect_back_or_default(users_path)      
    else
      flash[:error] = t('error.signup_disabled')
      redirect_back_or_default('/')      
    end
    
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      flash[:notice] = t('users.signup_ok')
      redirect_back_or_default('/login')
    else
      flash[:error]  = t('users.signup_error')
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = t('users.signup_complete')
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = t('users.activation_missing')
      redirect_back_or_default('/login')
    else 
      flash[:error]  = t('users.activation_wrong')
      redirect_back_or_default('/')
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_back_or_default('/')
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_back_or_default('/')
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t('users.updated')
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_back_or_default('/')
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])

      respond_to do |format|
        if user
          user.create_reset_code
          flash[:notice] = "Reset code sent to #{user.email}"

          format.html { redirect_to login_path }
          format.xml { render :xml => user.email, :status => :created }
        else
          flash[:error] = "#{params[:user][:email]} does not exist in system"

          format.html { redirect_to login_path }
          format.xml { render :xml => user.email, :status => :unprocessable_entity }
        end
      end

    end
  end
  

  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if !@user.present?
      redirect_to root_url
    else
      if request.post?
        if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
          self.current_user = @user
          @user.delete_reset_code
          flash[:notice] = "Password reset successfully for #{@user.email}"
          redirect_to root_url
        else
          render :action => :reset
        end
      end  
    end
  end


  # Might be a good addition to AR::Base
  def valid_for_attributes( model, attributes )
    unless model.valid?
      errors = model.errors
      our_errors = Array.new
      errors.each { |attr,error|
        if attributes.include? attr
          our_errors << [attr,error]
        end
      }
      errors.clear
      our_errors.each { |attr,error| errors.add(attr,error) }
      return false unless errors.empty?
    end
    return true
  end

  def reset_access
    @user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_back_or_default('/')
    end

    respond_to do |format|
      if @user.update_attribute(:access_code, @user.code_generator)
        flash[:notice] = t('users.change_calendar_token_ok')
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        flash[:error] = t('users.change_calendar_token_failed')
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  private

  def find_user
      if params[:id].present?
        @user = User.find_by_id(params[:id]) 
      else
        @user = User.find_by_id(current_user.id)
      end
  end
  
end
