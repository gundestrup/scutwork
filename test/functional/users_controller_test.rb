require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  # Index tests
  test "should get index admin user login" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test "should not get index non admin user login" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index
    assert_redirected_to user_path(user)
    assert_nil assigns(:users)
  end
  
  test "should try to get index -> redirect not login" do    
    get :index
    assert_redirected_to new_session_path
  end
  
  # New tests
  # $config.sign_up?
  # logged_in? && current_user.admin?
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should not get new admin signup disabled" do
    $config.sign_up = false    
    user = User.find_by_id(users(:one).id)
    login_as(user)
    @user = user
    get :new
    assert_redirected_to users_path
  end
  
  test "should not get new not admin signup disabled" do
    $config.sign_up = false
    user = User.find_by_id(users(:two).id)
    login_as(user)
    @user = user
    get :new
    assert_redirected_to '/'
  end

  # create tests
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :login => 'MyLoginTest', :name => 'my test name', :email => 'mytest@email2.dk', :language_id => languages(:english).id, :password => 'password', :password_confirmation => 'password'}
    end
    assert_redirected_to :login
  end
  
  test "should not create user douplicates" do
    assert_difference('User.count') do
      post :create, :user => { :login => 'MyLoginTest', :name => 'my test name', :email => 'mytest@email2.dk', :language_id => languages(:english).id, :password => 'password', :password_confirmation => 'password'}
      assert_equal I18n.t('users.signup_ok'), flash[:notice]
    end
    assert_redirected_to :login #user_path(assigns(:user))
    
    assert_no_difference('User.count') do
        post :create, :user => { :login => 'MyLoginTest', :name => 'my test name', :email => 'mytest@email2.dk', :language_id => languages(:english).id, :password => 'password', :password_confirmation => 'password'}
        assert_equal I18n.t('users.signup_error'), flash[:error]
        assert_response :success
    end
    
    assert_no_difference('User.count') do
        post :create, :user => { :login => 'MyLoginTest22', :name => 'my test name', :email => 'mytest@email2.dk', :language_id => languages(:english).id, :password => 'password', :password_confirmation => 'password'}
        assert_equal I18n.t('users.signup_error'), flash[:error]
        assert_response :success
    end
    
    assert_no_difference('User.count') do
        post :create, :user => { :login => 'MyLoginTest', :name => 'my test name', :email => 'mytest@email22.dk', :language_id => languages(:english).id, :password => 'password', :password_confirmation => 'password'}
        assert_equal I18n.t('users.signup_error'), flash[:error]
        assert_response :success
    end
  end

  # show tests
  test "should show user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => users(:one).id
    assert_response :success
  end
  
  test "should show other user admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :show, :id => users(:two).id
    assert_response :success
  end
  
  test "should not show other user not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :show, :id => users(:one).id
    assert_redirected_to user_path(user)
  end
  
  test "should not show user not logged in" do
    user = User.find_by_id(users(:one).id)
    get :show, :id => users(:one).id
    assert_redirected_to new_session_path
  end

  # edit tests
  test "should get edit" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => users(:one).id
    assert_response :success
  end
  
  test "should get edit admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :edit, :id => users(:two).id
    assert_response :success
  end
  
  test "should not get edit not logged in" do
    user = User.find_by_id(users(:one).id)
    get :edit, :id => users(:one).id
    assert_redirected_to new_session_path
  end
  
  test "should not get edit not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :edit, :id => users(:one).id
    assert_redirected_to user_path(user)
  end

  # update tests
  test "should update user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => users(:one).id, :user => { }
    assert_response :success
  end
  
  test "should update other user admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    put :update, :id => users(:two).id, :user => { }
    assert_response :success
  end

  test "should not update user not logged in" do
    user = User.find_by_id(users(:one).id)
    put :update, :id => users(:one).id, :user => { }
    assert_redirected_to new_session_path
  end
  
  test "should not update user not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    put :update, :id => users(:one).id, :shift => { }
    assert_redirected_to user_path(user)
  end

  # destroy tests
  test "should destroy user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end

    assert_redirected_to users_path
  end
  
  test "should destroy other user admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:two).id
    end
    assert_redirected_to users_path
  end
  
  test "should not destroy user not logged in" do
    user = User.find_by_id(users(:one).id)
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).id
    end
    assert_redirected_to new_session_path
  end
  
  test "should not destroy other user not admin" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).id
    end
    assert_redirected_to user_path(user)
  end
  
  # reset_access tests
  # @user = User.find_by_id(params[:id]) -> external access change
  # access_code change
  test "should change access code" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    @a = user.access_code.to_s
    get :reset_access, :id => users(:one).id
    user = User.find_by_id(users(:one).id)
    @b = user.access_code.to_s
    assert_not_equal @a, @b
    assert_redirected_to user_path(user)
  end
  
  test "should change access code other user admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    usertest = User.find_by_id(users(:two).id)
    @a = usertest.access_code.to_s
    get :reset_access, :id => users(:two).id
    usertest = User.find_by_id(users(:two).id)
    @b = usertest.access_code.to_s
    assert_not_equal @a, @b
    assert_redirected_to user_path(usertest)
  end
  
  test "should not change access code not logged in" do
    user = User.find_by_id(users(:one).id)
    @a = user.access_code.to_s
    get :reset_access, :id => users(:one).id
    @b = user.access_code.to_s
    assert_equal @a, @b
    assert_redirected_to new_session_path
    
  end
  
  test "should not change access code logged in other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    @a = user.access_code.to_s
    get :reset_access, :id => users(:one).id
    @b = user.access_code.to_s
    assert_equal @a, @b

    assert_redirected_to user_path(user)
    
  end
  
  
  # reset tests
  test "should reset user passwd from reset code" do
    get :reset, :reset_code => users(:two).reset_code
    assert_response :success
    post :reset, :reset_code => users(:two).reset_code, :user => {:password_confirmation => "123456", :password => "123456"}
    assert_response :redirect
  end
  
  test "should not reset user passwd from invalid reset code" do
    get :reset, :reset_code => 123
    assert_response :redirect
    post :reset, :reset_code => 123, :user => {:password_confirmation => "123456", :password => "123456"}
    assert_response :redirect
  end
  
  test "forgot -> email" do
    get :forgot
    assert_response :success
    
    post :forgot, :user => {:email => users(:one).email}    

    assert_equal 'Reset code sent to '+users(:one).email, flash[:notice]
    assert_response :redirect
    
  end
  
  test "forgot -> email not found" do
    missingemail = 'missing@email.at.all'
    get :forgot
    assert_response :success
    
    post :forgot, :user => {:email => missingemail}    

    assert_equal missingemail+' does not exist in system', flash[:error]
    assert_response :redirect
    
  end
  
  #post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:one).id
  
  # activate tests
  # when (!params[:activation_code].blank?) && user && !user.active?
  # when params[:activation_code].blank?
  
  test "activate missing code" do
    get :activate
    assert_response :redirect
    assert_redirected_to '/login'
  
    assert_equal I18n.t('users.activation_missing'), flash[:error]
    
  end
  
  test "activate incorrect code" do
    get :activate, :activation_code => 1234
    assert_response :redirect
    assert_redirected_to '/'
  end
  
end
