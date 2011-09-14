class Shift < ActiveRecord::Base  
  default_scope :order => 'start'

  belongs_to :user
  belongs_to :place
  has_many :payroles, :dependent => :destroy
  has_many :molds
  has_many :pays, :through => 'payroles'

  validates_presence_of :user_id, :start, :end, :place_id
  validates_uniqueness_of :start, :scope => :user_id
  
  before_create :make_uuid

  def self.user(user_id)
    @shifts = Shift.find(:all, :conditions => ['user_id = ? AND active = ?', user_id, true])
  end

  def self.user_all(user_id)
    @shifts = Shift.find(:all, :conditions => ['user_id = ?', user_id])
  end


  def pay_name
    pay.name if pay
  end

  def place_name
    place.name if place
  end
  

  def place_name=(name)
    # disable create action
    # self.place = Place.find_or_create_by_name(name) unless name.blank?

    self.place = Place.find_by_name(name) unless name.blank?
  end

  def mold
    mold.id if mold
  end

  def mold=(id)
    self.mold = Mold.find_by_id(id)
  end

  def mold_id
    mold.id if mold
  end

  def mold_id=(id)
    self.id = Mold.find_by_id(id)
  end

  def self.duration(shift_id)
    @shift = Shift.find_by_id(shift_id)
    duration = ((@shift.end-@shift.start) / 1.hour)*100
  end  

  def self.paytotal(shift_id)
    @payroles = Payrole.find(:all, :conditions => ['shift_id = ?', shift_id])
    @payroles.map { |p| p.hours*p.pay.rate*0.01 }.sum    
  end

  def self.payroletest(shift_id)
    if !(((@payroles = Payrole.find(:all, :conditions => ['shift_id = ?', shift_id], :order => 'hours' )).map { |p| p.hours}).last).present?
      'testlack'
    elsif Shift.duration(shift_id) >= ((@payroles = Payrole.find(:all, :conditions => ['shift_id = ?', shift_id], :order => 'hours' )).map { |p| p.hours}).last
      'testtrue'
    else
      'testfalse'
    end
  end

  def self.pay(user_id)
    @user = User.find_by_id(user_id)
    @user.pays.find(:all)
  end

  def self.place(user_id)
    @user = User.find_by_id(user_id)
    @user.places.find(:all)
  end

  def self.durationTotalInPeriode(shifts)
    totalduration = 0
    for shift in shifts
      totalduration = totalduration + Shift.duration(shift.id)
    end
    totalduration
  end

  private

  def make_uuid
      self.uuid = UUID.create.to_s
  end
  
end
