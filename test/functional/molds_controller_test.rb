require 'test_helper'

class MoldsControllerTest < ActionController::TestCase
  test "should get index" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_response :success
    assert_not_nil assigns(:molds)
  end

  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_response :success
  end

  test "should create mold" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Mold.count') do
      post :create, :mold => {:start_time => "08:00:00", :end_time => "15:00:00", :place_id => places(:MyPlace1User1).id, :name => 'MyTestName' }, :user_id => users(:one).id
    end

    assert_redirected_to user_mold_path(user, assigns(:mold))
  end

  test "should show mold" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => molds(:one).id, :user_id => users(:one).id
    assert_response :success
  end

  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => molds(:one).id, :user_id => users(:one).id
    assert_response :success
  end

  test "should update mold" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => molds(:one).id, :mold => { }, :user_id => users(:one).id
    assert_redirected_to user_mold_path(user, assigns(:mold))
  end

  test "should destroy mold" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Mold.count', -1) do
      delete :destroy, :id => molds(:one).id, :user_id => users(:one).id
    end

    assert_redirected_to user_molds_path(user)
  end
end
