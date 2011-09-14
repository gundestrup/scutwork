require 'test_helper'

class ShiftsControllerTest < ActionController::TestCase
  # There are tests that check for login, admin, owner of the item
  
  # Index tests
  test "should get index" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_response :success
    assert_not_nil assigns(:shifts)
  end
  
  test "should get index admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:two).id
    assert_response :success
    assert_not_nil assigns(:shifts)
  end

  test "should not get index" do    
    get :index, :user_id => users(:one).id
    assert_response :redirect
    assert_nil assigns(:shifts)
    assert_redirected_to :controller => 'session', :action => "new"
  end
  
  test "should not get index not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index, :user_id => users(:one).id    
    assert_nil assigns(:shifts)
    assert_redirected_to user_path(user)
  end

  # New tests
  test "should get new" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should get new admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :new, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not get new" do
    user = User.find_by_id(users(:one).id)
    get :new, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
  
  test "should not get new not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :new, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end

  # Create tests
  test "should create shift" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    # Setting time
    starttime = Time.now
    endtime = starttime + (60 * 60 * 8)
    assert_difference('Shift.count') do      
      post :create, { :shift => { :place_name =>"MyPlace1User1", :end => endtime, :start => starttime, :active => 1}, :user_id => users(:one).id }
    end
    assert_redirected_to user_shift_path(user, assigns(:shift))
  end
  
  test "should create shift admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    # Setting time
    starttime = Time.now
    endtime = starttime + (60 * 60 * 8)
    assert_difference('Shift.count') do      
      post :create, { :shift => { :place_name =>"MyPlace1User2", :end => endtime, :start => starttime, :active => 1}, :user_id => users(:two).id }
    end
    assert_redirected_to user_shift_path(users(:two).id, assigns(:shift))
  end

  test "should not create shift" do
    user = User.find_by_id(users(:one).id)
    # Setting time
    starttime = Time.now
    endtime = starttime + (60 * 60 * 8)
    assert_no_difference('Shift.count') do      
      post :create, { :shift => { :place_name =>"MyPlace1User1", :end => endtime, :start => starttime, :active => 1}, :user_id => users(:one).id }
    end
    assert_redirected_to new_session_path
  end
  
  test "should not create shift not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    # Setting time
    starttime = Time.now
    endtime = starttime + (60 * 60 * 8)
    assert_no_difference('Shift.count') do      
      post :create, { :shift => { :place_name =>"MyPlace1User1", :end => endtime, :start => starttime, :active => 1}, :user_id => users(:one).id }
    end
    assert_redirected_to user_path(user)
  end

  # Show tests
  test "should show shift" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => shifts(:two).id, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should show shift admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => shifts(:tree).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not show shift" do
    user = User.find_by_id(users(:one).id)
    get :show, :id => shifts(:one).id, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end

  test "should not show shift not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :show, :id => shifts(:two).id, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end

  # Edit tests
  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => shifts(:two).id, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should get edit admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => shifts(:tree).id, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not get edit" do
    user = User.find_by_id(users(:one).id)
    get :edit, :id => shifts(:two).id, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
  
  test "should not get edit not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :edit, :id => shifts(:two).id, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end
  

  # update tests
  test "should update shift" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => shifts(:one).id, :shift => { }, :user_id => users(:one).id
    assert_redirected_to user_shift_path(user, shifts(:one).id)
  end
  
  test "should update shift admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => shifts(:tree).id, :shift => { }, :user_id => users(:two).id
    assert_redirected_to user_shift_path(users(:two).id, shifts(:tree).id)
  end
  
  test "should not update shift not logged in" do
    user = User.find_by_id(users(:one).id)
    put :update, :id => shifts(:one).id, :shift => { }, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
  
  test "should not update shift not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    put :update, :id => shifts(:one).id, :shift => { }, :user_id => users(:one).id
    assert_redirected_to  user_path(user)
  end

  # destroy tests
  test "should destroy shift" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Shift.count', -1) do
      delete :destroy, :id => shifts(:one).id, :user_id => users(:one).id
    end
    assert_redirected_to user_shifts_path
  end
  
  test "should destroy shift admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('Shift.count', -1) do
      delete :destroy, :id => shifts(:tree).id, :user_id => users(:two).id
    end
    assert_redirected_to user_shifts_path
  end
  
  test "should not destroy shift" do
    user = User.find_by_id(users(:one).id)
    assert_no_difference('Shift.count') do
      delete :destroy, :id => shifts(:one).id, :user_id => users(:one).id
    end
    assert_redirected_to new_session_path
  end
  
  test "should not destroy shift not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_no_difference('Shift.count') do
      delete :destroy, :id => shifts(:one).id, :user_id => users(:one).id
    end
    assert_redirected_to user_path(user)
  end
end
