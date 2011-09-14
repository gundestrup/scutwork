class Paymaster < ActiveRecord::Base
  belongs_to :mold
  belongs_to :pay

  validates_presence_of :pay_id, :hours, :mold_id
  validates_uniqueness_of :mold_id, :scope => :pay_id

  validates_numericality_of :mold_id, :pay_id
  validates_numericality_of :hours, :greater_than_or_equal_to => 100
  
end
