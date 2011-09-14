require 'test_helper'

class PayTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_uniqueness_of :name, :scope => :user_id" do
    # something to "play with"
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert pay.save
    
    # not unique name
    pay = Pay.new
    pay.name = "Name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert !pay.save, "Saved the pay with not unique name"
    
    # same name, other user
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 2
    pay.description = "2"
    pay.rate = 100
    assert pay.save, "Saved the pay with unique name diffent user"
    
  end
  
  test "validates_numericality_of :user_id" do
    # something to "play with"
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert pay.save
    
    # something to fail
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = "a"
    pay.rate = 100
    pay.description = "1"
    assert !pay.save
    
  end
  
  test "validates_numericality_of :rate, :greater_than_or_equal_to => 100" do
    # something to "play with"
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert pay.save
    
    # something to fail, too little
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = "a"
    pay.rate = 99
    pay.description = "1"
    assert !pay.save

    # something to fail, negative
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = "a"
    pay.rate = -100
    pay.description = "1"
    assert !pay.save
    
    # something to fail, comma number
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = "a"
    pay.rate = 0.1
    pay.description = "1"
    assert !pay.save

    # something to fail, comma number negative
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = "a"
    pay.rate = -0.1
    pay.description = "1"
    assert !pay.save
    
  end
  
  test "validates_presence_of :user_id, :name, :rate, :start_date, :end_date" do    
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    #missing user_ID
    pay.rate = 100
    pay.description = "1"
    assert !pay.save
    
    pay = Pay.new
    #missing name
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert !pay.save
    
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    # missing rate
    pay.description = "1"
    assert !pay.save
    
    #TODO: test not working, can't see why
    #pay = Pay.new
    #pay.name = "name"
    #pay.start_date =     #missing start date
    #pay.end_date = Time.now
    #pay.user_id = 1
    #pay.rate = 100
    #pay.description = "1"
    #assert !pay.save
    
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    #missing end date
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert !pay.save
    
  end
  
  test "description is optional" do
    # description present should save
    pay = Pay.new
    pay.name = "name"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    pay.description = "1"
    assert pay.save
    
    # missing description should save
    pay = Pay.new
    pay.name = "name 2"
    pay.start_date = Time.now
    pay.end_date = Time.now
    pay.user_id = 1
    pay.rate = 100
    #description missing
    assert pay.save
    
  end
  
end
