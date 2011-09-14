require 'test_helper'

class ConfigurationsControllerTest < ActionController::TestCase
  test "should get index" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index
    assert_response :success
    assert_not_nil assigns(:configurations)
  end

  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => configurations(:one).id
    assert_response :success
  end

  test "should update configuration" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => configurations(:one).id, :configuration => { }
    assert_redirected_to configurations_path
  end

end
