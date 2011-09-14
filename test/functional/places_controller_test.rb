require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  # Index tests
  test "should get index admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_response :success
    assert_not_nil assigns(:places)
  end
  
  test "should get index admin other" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:two).id
    assert_response :success
    assert_not_nil assigns(:places)
  end
  
  test "should get index not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index, :user_id => users(:two).id
    assert_response :success
    assert_not_nil assigns(:places)
  end
  
  test "should not get index not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_redirected_to user_path(user)
    assert_nil assigns(:places)
  end
  
  test "should not get index not logged in" do    
    get :index, :user_id => users(:one).id
    assert_response :redirect
    assert_redirected_to new_session_path
    assert_nil assigns(:places)
  end

  # New tests
  test "should get new admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should get new" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :new, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should get new admin other" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not get new admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should not get new not logged in" do
    user = User.find_by_id(users(:one).id)
    get :new, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end

  # Create tests
  test "should create place admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Place.count') do
      post :create, { :place => { :name =>"MyPlace1User1Test"}, :user_id => users(:one).id }
    end
    assert_redirected_to user_places_path(user)
  end
  
  test "should create place admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Place.count') do
      post :create, { :place => { :name =>"MyPlace1User2Test"}, :user_id => users(:two).id }
    end
    assert_redirected_to user_places_path(users(:two))
  end
  
  test "should create place user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_difference('Place.count') do
      post :create, { :place => { :name =>"MyPlace1User2Test"}, :user_id => users(:two).id }
    end
    assert_redirected_to user_places_path(user)
  end
  
  test "should not create place not logged in" do
    user = User.find_by_id(users(:one).id)
    assert_no_difference('Place.count') do
      post :create, { :place => { :name =>"MyPlace1User1Test"}, :user_id => users(:one).id }
    end
    assert_redirected_to new_session_path
  end
  
  test "should not create place not admin other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_no_difference('Place.count') do
      post :create, { :place => { :name =>"MyPlace1User1Test"}, :user_id => users(:one).id }
    end
    assert_redirected_to user_path(user)
  end

  # Show tests
  test "should show place admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should show place admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should show place" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :show, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not show place not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :show, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_redirected_to user_path(users(:two))
  end
  
  test "should not show place not logged in" do
    user = User.find_by_id(users(:one).id)
    get :show, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end

  # Edit tests
  test "should get edit admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should get edit admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should get edit" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :edit, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not get edit not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :edit, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_redirected_to user_path(users(:two))
  end
  
  test "should not get edit not logged in" do
    user = User.find_by_id(users(:one).id)
    get :edit, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end

  # Update tests
  test "should update place admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => places(:MyPlace1User1).id, :place => { }, :user_id => users(:one).id
    assert_redirected_to user_places_path(user)
  end
  
  test "should update place admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => places(:MyPlace1User2).id, :place => { }, :user_id => users(:two).id
    assert_redirected_to user_places_path(users(:two))
  end
  
  test "should update place user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    put :update, :id => places(:MyPlace1User2).id, :place => { }, :user_id => users(:two).id
    assert_redirected_to user_places_path(user)
  end
  
  test "should not update place not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    put :update, :id => places(:MyPlace1User1).id, :place => { }, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end
  
  test "should not update place not logged_in" do
    user = User.find_by_id(users(:one).id)
    put :update, :id => places(:MyPlace1User1).id, :place => { }, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end

  # Destroy tests
  test "should destroy place admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Place.count', -1) do
      delete :destroy, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    end

    assert_redirected_to user_places_path(user)
  end
  
  test "should destroy place user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_difference('Place.count', -1) do
      delete :destroy, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    end

    assert_redirected_to user_places_path(user)
  end
  
  test "should destroy place other user admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Place.count', -1) do
      delete :destroy, :id => places(:MyPlace1User2).id, :user_id => users(:two).id
    end

    assert_redirected_to user_places_path(users(:two))
  end
  
  test "should not destroy place other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_no_difference('Place.count') do
      delete :destroy, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    end

    assert_redirected_to user_path(user)
  end
  
  test "should not destroy place not logged in" do
    user = User.find_by_id(users(:one).id)
    assert_no_difference('Place.count') do
      delete :destroy, :id => places(:MyPlace1User1).id, :user_id => users(:one).id
    end

    assert_redirected_to new_session_path
  end
end
