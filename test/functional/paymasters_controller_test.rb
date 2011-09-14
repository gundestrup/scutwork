require 'test_helper'

class PaymastersControllerTest < ActionController::TestCase
  
  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id, :mold_id => molds(:one).id
    assert_response :success
  end

  test "should create paymaster" do
    # {"paymaster"=>{"hours"=>"1500", "pay_id"=>"31"}, "commit"=>"Send", "mold_id"=>"17", "authenticity_token"=>"B+SrH7crfjfnpRX0/GKFyogOnx0U1WFVN3t1v2TjqTQ=", "user_id"=>"2"}
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Paymaster.count') do
      post :create, :paymaster => {:pay_id => pays(:two).id, :hours => 1500}, :user_id => users(:one).id, :mold_id => molds(:one).id
    end
    assert_redirected_to user_mold_path(user, molds(:one))
  end

  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => paymasters(:one).id, :user_id => users(:one).id, :mold_id => molds(:one).id
    assert_response :success
  end

  test "should update paymaster" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => paymasters(:one).id, :paymaster => { }, :user_id => users(:one).id, :mold_id => molds(:one).id
    assert_redirected_to user_mold_path(user, molds(:one))
  end

  test "should destroy paymaster" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Paymaster.count', -1) do
      delete :destroy, :id => paymasters(:one).id, :user_id => users(:one).id, :mold_id => molds(:one).id
    end

    assert_redirected_to user_mold_path(user, molds(:one))
  end
end
