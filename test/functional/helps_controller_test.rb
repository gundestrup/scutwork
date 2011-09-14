require 'test_helper'

class HelpsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  
  test "getting_started" do
    get :getting_started
    assert_response :success
  end
  
  test "help" do
    get :help
    assert_response :success
  end

  test "history" do
    get :history
    assert_response :success
  end

end
