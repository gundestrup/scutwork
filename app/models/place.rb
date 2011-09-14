class Place < ActiveRecord::Base
  default_scope :order => 'name'
  
  has_many :shifts, :dependent => :destroy
  has_many :molds, :dependent => :destroy
  belongs_to :user

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false

  def self.shifts(place_id, active=1)
    if active == 'all'
      @shifts = Shift.find(:all, :conditions => ['place_id = ?', place_id])
    elsif active == nil
      @shifts = Shift.find(:all, :conditions => ['place_id = ? AND active = ?', place_id, true])
    else
      @shifts = Shift.find(:all, :conditions => ['place_id = ? AND active = ?', place_id, active])
    end
  end

end
