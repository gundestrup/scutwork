class Language < ActiveRecord::Base
  has_many :users
  
  validates_presence_of :name, :description
  validates_uniqueness_of :name, :description, :case_sensitive => false
  
end
