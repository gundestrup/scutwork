class LanguagesController < ApplicationController
  before_filter :login_required, :find_user, :admin


  # GET /languages/new
  # GET /languages/new.xml
  def new
    @language = Language.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @language }
    end
  end

  # GET /languages/1/edit
  def edit
    @language = Language.find_by_id(params[:id])
  end

  # POST /languages
  # POST /languages.xml
  def create
    @language = Language.new(params[:language])

    respond_to do |format|
      if @language.save
        flash[:notice] = t('language.created')
        format.html { redirect_to(configurations_path) }
        format.xml  { render :xml => @language, :status => :created, :location => @language }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /languages/1
  # PUT /languages/1.xml
  def update
    @language = Language.find_by_id(params[:id])

    respond_to do |format|
      if @language.update_attributes(params[:language])
        flash[:notice] = t('language.updated')
        format.html { redirect_to(configurations_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => edit }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.xml
  def destroy
    @language = Language.find_by_id(params[:id])
    @language.destroy

    respond_to do |format|
      format.html { redirect_to(configurations_path) }
      format.xml  { head :ok }
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
