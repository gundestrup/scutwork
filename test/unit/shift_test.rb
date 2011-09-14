require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of :user_id, :start, :end, :place_id" do
    shift = Shift.new
    #shift.user_id = 1
    shift.start = Time.now
    shift.end = Time.now
    shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 1
    #shift.start = Time.now
    shift.end = Time.now
    shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 1
    shift.start = Time.now
    #shift.end = Time.now
    shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 1
    shift.start = Time.now
    shift.end = Time.now
    #shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 1
    shift.start = Time.now
    shift.end = Time.now
    shift.place_id = 1
    assert shift.save
  end
  
  test "validates_uniqueness_of :start, :scope => :user_id" do
    a = Time.now
    b = Time.now
    shift = Shift.new
    shift.user_id = 1
    shift.start = a
    shift.end = b
    shift.place_id = 1
    assert shift.save
    
    shift = Shift.new
    shift.user_id = 1
    shift.start = a
    shift.end = Time.now
    shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 1
    shift.start = b
    shift.end = Time.now
    shift.place_id = 1
    assert !shift.save
    
    shift = Shift.new
    shift.user_id = 2
    shift.start = a
    shift.end = b
    shift.place_id = 1
    assert shift.save
  end
end
