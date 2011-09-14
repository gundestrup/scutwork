class CalendarToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :access_code, :string

    @users = User.find(:all)

    for user in @users do
      code_generator(user.id)
    end
  end

  def self.down
    remove_column :users, :access_code
  end

  protected

  def self.code_generator(user_id)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    access_code  =  (0..50).map{ o[rand(o.length)]  }.join
    user = User.find_by_id(user_id)
    user.access_code = access_code
    user.save    
    
  end
end
