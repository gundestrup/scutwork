# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include AuthenticatedSystem

  require 'uuid'  
  helper :all # include all helpers, all the time
  layout 'application'

  before_filter :set_locale
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4871061a839106c006576e273813b0d0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  if Configuration.table_exists?
      $config = Configuration.find(:first, :conditions => ['id = ?', 1] )
  end

  protected

  def find_user
     @user = User.find_by_id(params[:user_id])
  end

  def authorize
    if @user.present? or current_user.admin       
      if @user.id == current_user.id or current_user.admin
      else
        redirect_to user_path(current_user)
        flash[:error] = t('error.cant_access_others_information')
      end
    else
      redirect_to user_path(current_user)
      flash[:error] = t('error.cant_access_information')
    end
  end

  def set_locale
    if logged_in?
      I18n.locale = current_user.language.name
    end    
  end


end
