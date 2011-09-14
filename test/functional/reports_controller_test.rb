require 'test_helper'

class ReportsControllerTest < ActionController::TestCase

  # Index tests
  test "should show the report page admin" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => user
    assert_response :success
  end
  
  test "should show the report page admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    get :index, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should show the report page norm user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not show the report page norm user other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    get :index, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end

  test "should not show the report page not logged in" do
    user = User.find_by_id(users(:one).id)    
    get :index, :user_id => user
    assert_redirected_to new_session_path
  end
  
  # Month tests
  # TODO params[:date] "date"=>{"month"=>"3", "year"=>"2011"}}
  test "should show month admin user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :month, :date => {:month => Time.now.month, :year => Time.now.year}, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should show month admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :month, :date => {:month => Time.now.month, :year => Time.now.year}, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should show month user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :month, :date => {:month => Time.now.month, :year => Time.now.year}, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not show month other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :month, :date => {:month => Time.now.month, :year => Time.now.year}, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end
  
  test "should not show month user not logged in" do
    user = User.find_by_id(users(:one).id)
    post :month, :date => {:month => Time.now.month, :year => Time.now.year}, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
  # Year tests
  # TODO params[:date] "date"=>{"year"=>"2011"}
  test "should show year admin user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :year, :date => {:year => Time.now.year}, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should show year admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :year, :date => {:year => Time.now.year}, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should show year user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :year, :date => {:year => Time.now.year}, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should not show year other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :year, :date => {:year => Time.now.year}, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end
  
  test "should not show year not logged in" do
    user = User.find_by_id(users(:one).id)
    post :year, :date => {:year => Time.now.year}, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
  
  # Norm tests
  # "date"=>{"start"=>"2011-3-25", "normduration"=>"5"}
  test "should show norm admin user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:one).id
    assert_response :success
  end
  
  test "should show norm admin other user" do
    user = User.find_by_id(users(:one).id)
    login_as(user)
    post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:two).id
    assert_response :success
  end
  
  test "should show norm user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:two).id
    assert_response :success
  end

  test "should not show norm other user" do
    user = User.find_by_id(users(:two).id)
    login_as(user)
    post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:one).id
    assert_redirected_to user_path(user)
  end
  
  test "should not show norm user not logged in" do
    user = User.find_by_id(users(:one).id)
    post :norm, :date => {:start => "2011-3-25", :normduration => 4}, :user_id => users(:one).id
    assert_redirected_to new_session_path
  end
end
