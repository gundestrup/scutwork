require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "validates_presence_of     :login" do
    user = User.new
    #user.login = "login"
    user.name = "name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "MyloginToTest"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
  end
  
  test "validates_length_of       :login,    :within => 3..40" do
    # 2 char missing 1
    user = User.new
    user.login = "1a"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    # 41 char
    user = User.new
    user.login = "12345678901234567890123456789012345678901a"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    # 3 char (valid)
    user = User.new
    user.login = "12a"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    # 4 char (valid)
    user = User.new
    user.login = "1234"
    user.name = "My name"
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
  end
  
  test "validates_uniqueness_of   :login, :case_sensitive => false" do
    user = User.new
    user.login = "abcd"
    user.name = "My name"
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    user = User.new
    user.login = "Abcd"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "ABcd"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcde"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
  end
  
  test "validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message" do
    user = User.new
    user.login = "Abcd%"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
        
    user = User.new
    user.login = "Abcd+"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd-"
    user.name = "My name"
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    user = User.new
    user.login = "Abcd"
    user.name = "My name"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
  end
  
  test "validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message , #{}:allow_nil => true" do
    
    user = User.new
    user.login = "Abcd1"
    user.name = "My+name-"
    user.email = "email1@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = "My name"
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    user = User.new
    user.login = "Abcd3"
    user.name = "My-name"
    user.email = "email3@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
  end
  
  test "validates_length_of       :name,     :maximum => 100" do
    #1 char
    user = User.new
    user.login = "Abcd"
    user.name = "M"
    user.email = "email@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    #101 chars ups
    user = User.new
    user.login = "Abcd2"
    user.name = (0...101).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    #100 chars
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
  end
  
  test "validates_presence_of       :name " do
    user = User.new
    user.login = "Abcd2"
    #user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
  end
  
  test "validates_presence_of     :email" do
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    #user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
  end
  
  test "validates_length_of       :email,    :within => 6..100 #r@a.wk" do
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = (0...100).map{65.+(rand(25)).chr}.join+"@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = (0...100).map{65.+(rand(25)).chr}.join+"@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email@"+(0...100).map{65.+(rand(25)).chr}.join+".dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
  end
  
  test "validates_uniqueness_of   :email, :case_sensitive => false" do
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
  end
  
  test "validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message" do
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "@email.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2@dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
    user = User.new
    user.login = "Abcd2"
    user.name = (0...100).map{65.+(rand(25)).chr}.join
    user.email = "email2.dk"
    user.language_id = 2
    user.crypted_password = "0d0ad12f918ae9c89c226d8fa3ff528e146daaf6"
    user.salt = "30f6eadfee81e8e34c56dbaf642d6035e2d4c04e"
    assert !user.save
    
  end
  
end
