require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "error admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    current_user = user
    assert_raises RuntimeError do
       get :error
    end
  end
  
  test "error user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    current_user = user
    assert_raises RuntimeError do
       get :error
    end
    #assert_redirected_to user_path(user)
  end
  
  test "error not logged in" do    
    assert_raises RuntimeError do
       get :error
    end
    #assert_redirected_to new_session_path
  end
end
