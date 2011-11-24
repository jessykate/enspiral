class Booking < ActiveRecord::Base
  belongs_to :project
  belongs_to :person

  validates :time, :presence => true, :numericality => {:greater_than_or_equal_to => 0, :less_than => 168}
end
