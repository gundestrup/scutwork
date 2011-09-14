class AdminsController < ApplicationController
  before_filter :login_required, :find_user, :admin
  
   def error
        raise RuntimeError, "Generating an error"
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
