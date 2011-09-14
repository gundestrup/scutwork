require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of :name, :user_id" do
    place = Place.new
    #place.name = "name"
    place.user_id = 1
    assert !place.save
    
    place = Place.new
    place.name = "name"
    #place.user_id = 1
    assert !place.save
  end
  
  test "validates_uniqueness_of :name, :scope => :user_id" do
    place = Place.new
    place.name = "name"
    place.user_id = 1
    assert place.save
    
    place = Place.new
    place.name = "Name"
    place.user_id = 1
    assert !place.save
    
    place = Place.new
    place.name = "name"
    place.user_id = 2
    assert place.save
  end
end
