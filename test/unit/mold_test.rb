require 'test_helper'

class MoldTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of :name, :start_time, :end_time, :user_id, :place_id" do
    #test missing place_id
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 1
    assert !mold.save, "Saved the mold without place_id"

    #test missing user_id  
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.place_id = 1
    assert !mold.save, "Saved the mold without user_id"

    #missing end_time
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert !mold.save, "Saved the mold without end_time"
    
    #missing start_time
    mold = Mold.new
    mold.name = "name"
    mold.end_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert !mold.save, "Saved the mold without start_time"
    
    #missing name
    mold = Mold.new
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert !mold.save, "Saved the mold without name"
    
    #test working
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert mold.save, "Saved the mold"
  end
  
  test "validates_uniqueness_of :name, :scope => :user_id" do
    # something to "play with"
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert mold.save
    
    # not unique name
    mold = Mold.new
    mold.name = "Name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 1
    mold.place_id = 1
    assert !mold.save, "Saved the mold with not unique name"
    
    # same name, other user
    mold = Mold.new
    mold.name = "name"
    mold.start_time = Time.now
    mold.end_time = Time.now
    mold.user_id = 2
    mold.place_id = 2
    assert mold.save, "Saved the mold with unique name diffent user"
    
  end
  
end
