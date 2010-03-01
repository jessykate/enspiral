class Person < ActiveRecord::Base
  is_gravtastic! :rating => 'PG'
  
  has_many :worked_on
  has_many :projects, :through => :worked_on
  
  validates_presence_of :email
end
