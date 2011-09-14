require 'test_helper'

class CalendarsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "index (ical test) own" do
    get :index, {:user_id => users(:one).id.to_s, :access_code => users(:one).access_code.to_s}
    assert_response :success
  end
  
  test "index (ical test) external" do
      get :index, {:feed_id => feeds(:one).id.to_s, :access_code => feeds(:one).access_code.to_s}
      assert_response :success
  end
  
  test "google" do
    get :google, {:user_id => users(:one).id.to_s, :access_code => users(:one).access_code.to_s}
    assert_response :success
  end
  
  test "excel" do
    get :excel, {:user_id => users(:one).id.to_s, :access_code => users(:one).access_code.to_s}
    assert_response :success
  end
end
