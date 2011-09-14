require 'test_helper'

class PayrolesControllerTest < ActionController::TestCase
  
  # New tests
  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id, :shift_id => shifts(:one).id
    assert_response :success
  end

  # Create tests
  test "should create payrole" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Payrole.count') do
      post :create, :payrole => {:pay_id => pays(:two).id, :hours => 700 }, :user_id => users(:one).id, :shift_id => shifts(:one).id
    end

    assert_redirected_to user_shift_path(user, shifts(:one))
  end

  # Edit tests
  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => payroles(:one).id, :user_id => users(:one).id, :shift_id => shifts(:one).id
    assert_response :success
  end

  # Updat tests
  test "should update payrole" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => payroles(:one).id, :payrole => { }, :user_id => users(:one).id, :shift_id => shifts(:one).id
    assert_redirected_to user_shift_path(user, shifts(:one))
  end

  # Destroy tests
  test "should destroy payrole" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Payrole.count', -1) do
      delete :destroy, :id => payroles(:one).id, :user_id => users(:one).id, :shift_id => shifts(:one).id
    end

    assert_redirected_to user_shift_path(user, shifts(:one))
  end
end
