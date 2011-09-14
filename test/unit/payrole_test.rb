require 'test_helper'

class PayroleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of :shift_id, :pay_id, :hours" do
    payrole = Payrole.new
    #payrole.shift_id = 1
    payrole.pay_id = 1
    payrole.hours = 100
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 1
    #payrole.pay_id = 1
    payrole.hours = 100
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 1
    payrole.pay_id = 1
    #payrole.hours = 100
    assert !payrole.save
  end
  
  test "validates_uniqueness_of :shift_id, :scope => :pay_id" do
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = 100
    assert payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = 100
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 3
    payrole.pay_id = 2
    payrole.hours = 100
    assert payrole.save
  end
  
  test "validates_numericality_of :shift_id" do
    payrole = Payrole.new
    payrole.shift_id = "a"
    payrole.pay_id = 2
    payrole.hours = 100
    assert !payrole.save
  end
  
  test "validates_numericality_of :pay_id" do    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = "a"
    payrole.hours = 100
    assert !payrole.save
  end
  
  test "validates_numericality_of :hours, :greater_than_or_equal_to => 100" do 
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = 99
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = -99
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = -100
    assert !payrole.save
        
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = 0.5
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = -0.5
    assert !payrole.save
    
    payrole = Payrole.new
    payrole.shift_id = 2
    payrole.pay_id = 2
    payrole.hours = 100
    assert payrole.save
    
  end

end
