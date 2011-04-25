class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :creator, :class_name => 'Person'

  validates_presence_of :amount, :account_id, :description, :date

  after_create :update_account
  after_destroy :update_account

  validates_numericality_of :amount

  def self.transactions_with_totals(transactions)
    return []  if transactions.nil?
    total = 0
    transactions_wt = []

    transactions.reverse.each do |transaction|
      total += transaction.amount
      transactions_wt << [transaction, total]
    end

    transactions_wt.reverse
  end

  private

  def update_account
    account.calculate_balance
  end
end
