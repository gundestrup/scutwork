require 'test_helper'

class PaymasterTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of :pay_id, :hours, :mold_id" do
    paymaster = Paymaster.new
    #paymaster.mold_id = 1
    paymaster.pay_id = 1
    paymaster.hours = 100
    assert !paymaster.save
    
    paymaster = Paymaster.new
    paymaster.mold_id = 1
    #paymaster.pay_id = 1
    paymaster.hours = 100
    assert !paymaster.save
    
    paymaster = Paymaster.new
    paymaster.mold_id = 1
    paymaster.pay_id = 1
    #paymaster.hours = 100
    assert !paymaster.save
  end
  
  test "validates_uniqueness_of :mold_id, :scope => :pay_id" do
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = 100
    assert paymaster.save
    
    #duplicate?
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = 100
    assert !paymaster.save
    
    #not duplicate, mold id different
    paymaster = Paymaster.new
    paymaster.mold_id = 3
    paymaster.pay_id = 2
    paymaster.hours = 100
    assert paymaster.save
  end
  
  test "validates_numericality_of :mold_id, :pay_id" do
    paymaster = Paymaster.new
    paymaster.mold_id = "a"
    paymaster.pay_id = 2
    paymaster.hours = 100
    assert !paymaster.save
    
    paymaster = Paymaster.new
    paymaster.mold_id = 3
    paymaster.pay_id = "a"
    paymaster.hours = 100
    assert !paymaster.save
  end
  
  test "validates_numericality_of :hours, :greater_than_or_equal_to => 100" do
    #under 100 limit
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = 99
    assert !paymaster.save
        
    
    #negative under 100 limit
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = -99
    assert !paymaster.save
    
    #negative at 100
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = -100
    assert !paymaster.save
    
    #comma
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = 0.5
    assert !paymaster.save
    
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = -0.5
    assert !paymaster.save
    
    #working
    paymaster = Paymaster.new
    paymaster.mold_id = 2
    paymaster.pay_id = 2
    paymaster.hours = 100
    assert paymaster.save
    
  end
  
end
