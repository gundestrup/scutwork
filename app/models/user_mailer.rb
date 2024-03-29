class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://scutwork.dk/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://scutwork.dk/"
  end

  def reset_notification(user)
    setup_email(user)
    @subject    += 'Link to reset your password'
    @body[:url]  = "http://scutwork.dk/reset/#{user.reset_code}"
  end

  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "webmaster@scutwork.dk"
      @subject     = "[Scutwork] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
