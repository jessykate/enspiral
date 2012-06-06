class Customer < ActiveRecord::Base
  belongs_to :company
  validates_presence_of :company
  default_scope order(:name)
  has_many :invoices
  has_many :projects
  delegate :default_contribution, to: :company
  delegate :accounts, to: :company
end
