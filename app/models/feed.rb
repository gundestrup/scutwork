class Feed < ActiveRecord::Base
  belongs_to :user

  before_create :code_generator

  validates_presence_of :name, :expire, :user_id

  def active
    expire >= Date.today
  end
  private
  def code_generator
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    self.access_code  =  (0..50).map{ o[rand(o.length)]  }.join
  end
end
