class Payrole < ActiveRecord::Base
  belongs_to :shift
  belongs_to :pay

  validates_presence_of :shift_id, :pay_id, :hours
  validates_uniqueness_of :shift_id, :scope => :pay_id

  validates_numericality_of :shift_id
  validates_numericality_of :pay_id
  validates_numericality_of :hours, :greater_than_or_equal_to => 100

  def self.money(payrole_id)
    @payrole = Payrole.find(payrole_id)
    pay = (@payrole.hours * 0.01 * @payrole.pay.rate)
  end

  def self.shifttest(shift_id, pay_id)
    @payrole = Payrole.find(pay_id)
    if Shift.duration(shift_id) >= @payrole.hours
      'shifttrue'
    else
      'shiftfalse'
    end
  end
  
end
