require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new
    assert_response :success
  end

  test "should create language" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Language.count') do
      post :create, :language => {:name => 'te', :description => 'Test description' }
    end

    assert_redirected_to configurations_path
  end

  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => languages(:dansk).id
    assert_response :success
  end

  test "should update language" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => languages(:dansk).id, :language => { }
    assert_redirected_to configurations_path
  end

  test "should destroy language" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Language.count', -1) do
      delete :destroy, :id => languages(:dansk).id
    end

    assert_redirected_to configurations_path
  end
end
