require 'spec_helper'

describe Company do
  it {should have_many :accounts}
  it {should belong_to :support_account}
  it {should belong_to :income_account}
  it {should have_many :company_memberships}
  it {should have_many :people}
  it {should have_many :admins}
  it {should validate_numericality_of :default_commission}
  it {should have_many :clients}
  it {should have_many :projects}
  it {should validate_presence_of :name}

  it 'creates missing support and income accounts after create' do
    company = Company.make 
    company.support_account = nil
    company.income_account = nil
    company.save
    company.support_account.should_not be_nil
    company.income_account.should_not be_nil
  end

  it 'uses supplied support, income accounts on create' do
    company = Company.make 
    income_account = Account.make!
    support_account = Account.make!
    company.income_account = income_account
    company.support_account = support_account
    company.save
    company.support_account.should == support_account
    company.income_account.should == income_account
  end
end