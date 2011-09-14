class Mold < ActiveRecord::Base
  default_scope :order => 'name'

  belongs_to :user
  belongs_to :shift
  belongs_to :place  
  has_many :paymasters, :dependent => :destroy
  has_many :pays, :through => :paymasters

  validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false

  validates_presence_of :name, :start_time, :end_time, :user_id, :place_id

  def place_name
    place.name if place
  end


  def place_name=(name)
    # disable create action
    # self.place = Place.find_or_create_by_name(name) unless name.blank?
    self.place = Place.find_by_name(name) unless name.blank?
  end

  def duration_nice
    seconds = end_time-start_time
    hours = mins = 0
  if seconds >=  60 then
    mins = (seconds / 60).to_i
    seconds = (seconds % 60 ).to_i

    if mins >= 60 then
      hours = (mins / 60).to_i
      mins = (mins % 60).to_i
    end
  end
  [hours,mins]
  end

  def duration
    if start_time.hour > end_time.hour
      (24-((start_time-end_time) / 1.hour))*100
    else
      ((end_time-start_time) / 1.hour)*100
    end

  end

  def self.duration_test(mold_id)
    @mold = Mold.find_by_id(mold_id)
    if @mold.end_time < @mold.start_time
      duration = 2400+((@mold.end_time - @mold.start_time) / 1.hour)*100
    else
       duration = ((@mold.end_time - @mold.start_time) / 1.hour)*100
    end
  end


  def duration_hours
    if start_time.hour > end_time.hour
      (24-start_time.hour+end_time.hour-1)*60*60
    else
      (end_time.hour-start_time.hour)*60*60
    end
  end

  def duration_minutes
    if start_time.hour > end_time.hour
      (60-start_time.min+end_time.min)*60
    else
      (end_time.min-start_time.min)*60
    end

  end

  def self.paymastertest(mold_id)
    if !(((@payroles = Paymaster.find(:all, :conditions => ['mold_id = ?', mold_id], :order => 'hours' )).map { |p| p.hours}).last).present?
      'testlack'
    elsif Mold.duration_test(mold_id) >= ((@paymasters = Paymaster.find(:all, :conditions => ['mold_id = ?', mold_id], :order => 'hours' )).map { |p| p.hours}).last
      'testtrue'
    else
      'testfalse'
    end
  end

  def self.paytotal(mold_id)
    @paymasters = Paymaster.find(:all, :conditions => ['mold_id = ?', mold_id])
    @paymasters.map { |p| p.hours*p.pay.rate*0.01 }.sum    
  end

  
end
