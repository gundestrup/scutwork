class HelpsController < ApplicationController
  before_filter :find_user
  
  def getting_started
    
  end

  def help

  end

  def history

  end

  protected

  def find_user
    if logged_in?
      @user = current_user
    end    
  end

end
