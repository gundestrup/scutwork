class ConfigurationsController < ApplicationController
  before_filter :login_required, :find_user, :admin

  # GET /configurations
  # GET /configurations.xml
  def index
    @configurations = Configuration.find(:all)
    @languages = Language.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @configurations }
    end
  end

  # GET /configurations/1/edit
  def edit
    @configuration = Configuration.find_by_id(params[:id])
  end

  # PUT /configurations/1
  # PUT /configurations/1.xml
  def update
    @configuration = Configuration.find_by_id(params[:id])

    respond_to do |format|
      if @configuration.update_attributes(params[:configuration])
        flash[:notice] = t('configuration.updated')
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
      end
    end
  end


  protected

  def admin
       if current_user.admin
       else         
         redirect_to :controller => "users", :action => 'index'
         flash[:error] = t('error.no_access')
       end
  end

  def find_user
     @user = User.find_by_id(current_user.id)
  end
  
end
