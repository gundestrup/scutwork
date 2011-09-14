require 'test_helper'

class PaysControllerTest < ActionController::TestCase
  #Index texts
  test "should get index admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_response :success
    assert_not_nil assigns(:pays)
  end

  #New tests
  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_response :success
  end

  #create Tests
  test "should create pay" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Pay.count') do
      post :create, {:pay => {:start_date => Time.now, :end_date => (Time.now + 1000000000), :name => 'name', :rate => 300, :description => 'name rate 300' }, :user_id => users(:one).id}
    end

    assert_redirected_to user_pays_path(user)
  end

  #Show tests
  test "should show pay" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => pays(:one).id, :user_id => users(:one).id
    assert_response :success
  end

  # Edit tests
  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => pays(:one).id, :user_id => users(:one).id
    assert_response :success
  end

  # Update tests
  test "should update pay" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => pays(:one).id, :pay => { }, :user_id => users(:one).id
    assert_redirected_to user_pays_path(user)
  end

  # Destroy tests
  test "should destroy pay" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Pay.count', -1) do
      delete :destroy, :id => pays(:one).id, :user_id => users(:one).id
    end

    assert_redirected_to user_pays_path(user)
  end
end
