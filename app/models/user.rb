require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :shifts, :dependent => :destroy
  has_many :pays, :dependent => :destroy
  has_many :places, :dependent => :destroy
  has_many :molds, :dependent => :destroy
  has_many :feeds, :dependent => :destroy
  belongs_to :language
  
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login, :case_sensitive => false
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message#, :allow_nil => true
  validates_length_of       :name,     :maximum => 100
  validates_presence_of     :name

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email, :case_sensitive => false
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  validates_presence_of     :language_id

  before_create :make_activation_code, :code_generator 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :email_confirmation, :name, :password, :password_confirmation, :language_id, :reset_code, :normstart, :norm_id

  attr_accessor :updating_email, :confirming_email  # allows us to control when email uniqueness and confirmation are validated (respectively)


  def self.payrole(user_id, active=true)
    @payroles = Payrole.find(:all, :conditions => ['shifts.user_id = ? AND shifts.active = ?', user_id, active], :include => 'shift')
    @payroles.map { |p| p.hours*p.pay.rate*0.01 }.sum
  end
  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  #reset methods
  def create_reset_code
    @reset = true
    self.attributes = {:reset_code => Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )}
    save(false)
  end

  def recently_reset?
    @reset
  end

  def delete_reset_code
    self.attributes = {:reset_code => nil}
    save(false)
  end

  def code_generator
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    self.access_code  =  (0..50).map{ o[rand(o.length)]  }.join
  end

 protected
   def updating_email?
     # validate_uniqueness_of email unless specifically set to false
     if updating_email == false
       return false
     else
       return true
     end
   end

    
    def make_activation_code
        self.activation_code = self.class.make_token
    end

end
