class Pay < ActiveRecord::Base
  default_scope :order => ['name ASC']
  named_scope :active, :conditions => { :active => true }
  named_scope :deactive, :conditions => { :active => false }
  
  has_many :molds
  belongs_to :user
  has_many :payroles, :dependent => :destroy
  has_many :paymasters, :dependent => :destroy

  validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false

  validates_numericality_of :user_id
  validates_numericality_of :rate, :greater_than_or_equal_to => 100
  
  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :rate
  validates_presence_of :start_date
  validates_presence_of :end_date
  

  def self.user(user_id)
    @pays = Pay.find(:all, :conditions => ['user_id = ? and active = true', user_id], :order => 'name')
  end

  def self.user_all(user_id)
    @pays = Pay.find(:all, :conditions => ['user_id = ?', user_id], :order => 'name')
  end

  def namerate
    "#{name}: "+"#{((rate).to_f)/100}kr"
  end

  
end
