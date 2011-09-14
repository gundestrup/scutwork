class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :admin,                     :boolean, :default => false

    end
    add_index :users, :login, :unique => true
    #Creating an admin user
    #Please change your email, and use the "forgot password" function for create a password
    @user = User.new
    @user.login = 'Admin'
    @user.name = 'Administrator'
    @user.email = 'adminemail'
    @user.admin = 'true'
    @user.crypted_password = 'some cryped password'
    @user.salt = 'some salt'
    @user.save
  end

  def self.down
    drop_table "users"
  end

end
