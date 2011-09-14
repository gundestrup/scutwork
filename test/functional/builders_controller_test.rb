require 'test_helper'

class BuildersControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "shift admin user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    #Parameters: "mold"=>{"mold_id"=>"15", "start"=>"2011-3-31"}}
    assert_difference('Shift.count') do
      post :shift, :mold => {:mold_id => molds(:one).id, :start => "2011-3-30"}
    end
    assert_difference('Payrole.count') do
      post :shift, :mold => {:mold_id => molds(:one).id, :start => "2011-3-31"}
    end
  end
  
  test "shift admin user other" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    #Parameters: "mold"=>{"mold_id"=>"15", "start"=>"2011-3-31"}}
    assert_difference('Shift.count') do
      post :shift, :mold => {:mold_id => molds(:tree).id, :start => "2011-3-30"}
    end
    assert_difference('Payrole.count') do
      post :shift, :mold => {:mold_id => molds(:tree).id, :start => "2011-3-31"}
    end
  end
  
  test "pay_kbu" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Pay.count', 8) do
      get :pay_kbu, :user_id => users(:one)
    end
    assert_response :redirect
  end
end
