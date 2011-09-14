require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  test "should get index" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:one)
    assert_response :success
    assert_not_nil assigns(:feeds)
  end

  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one)
    assert_response :success
  end

  test "should create feed" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Feed.count') do
      post :create, :feed => {:name => 'my new feed', :access_code =>'my secret access code', :expire => (Time.now + 100000) }, :user_id => users(:one).id
    end

    assert_redirected_to user_feeds_path(user)
  end

  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => feeds(:one).to_param, :user_id => users(:one)
    assert_response :success
  end

  test "should update feed" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => feeds(:one).to_param, :feed => { }, :user_id => users(:one)
    assert_redirected_to user_feeds_path(user)
  end

  test "should destroy feed" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Feed.count', -1) do
      delete :destroy, :id => feeds(:one).to_param, :user_id => users(:one)
    end

    assert_redirected_to user_feeds_path(user)
  end
end
