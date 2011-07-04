require 'machinist/active_record'


Customer.blueprint do
  name { Faker::Company.name }
end

Invoice.blueprint do
  customer
  number { rand(20000) }
  amount {(rand(99) + 1) * 1000}
  paid { false }
  currency { "NZD" }
  date { rand(15).days.ago }
  due { rand(30).days.from_now }
end

InvoiceAllocation.blueprint do
  disbursed { false }
  currency { "NZD" }
  amount { 1 } 
  person
  invoice
end

def make_invoice_allocation
  make_invoice_allocation_for
end

def make_invoice_allocation_for invoice=nil, person=nil, proportion = 0.75
  invoice ||= Invoice.make
  person ||= Person.make
  allocation = InvoiceAllocation.new plan_invoice_allocation_for(invoice, person, proportion)
  allocation.save
  allocation
end

def plan_invoice_allocation_for invoice, person, proportion = 0.75
  { :invoice => invoice,
    :person => person,
    :amount => invoice.amount * proportion,
    :currency => invoice.currency,
    :disbursed => false }
end

Person.blueprint do
  email { Faker::Internet.email }
  user
end

Person.blueprint(:account_holder) do
  account
  user {User.make}
  has_gravatar {"true".to_s}
end

Person.blueprint(:admin) do
  last_name { Faker::Name.last_name + " (admin)" }
  user { User.make(:admin) }
end

Person.blueprint(:staff) do
  last_name { Faker::Name.last_name + " (staff)" }
  user { User.make(:staff) }
end

def make_person(role = nil)
 p = Person.make(role) 
 p.user.person = p
 p
end

User.blueprint do
  email { Faker::Internet.email }
  role {"staff"}
  password { 'secret' }
  password_confirmation { 'secret' }
end

User.blueprint(:admin) do
  role {"admin"}
end

User.blueprint(:staff) do
  role {"staff"}
end

Account.blueprint do
  person
end

Transaction.blueprint do
  description { "this is a transaction" }
  amount { rand(5000) - 2500 }
  date { rand(15).days.ago }
  account
  creator
end

Notice.blueprint do
  summary { 'this is a summary' }
  text { 'this is a text' }
  person
end

Comment.blueprint do
  text { 'this is a text'}
  commentable { Notice.make }
  person
end

Comment.blueprint(:comment) do
  text { 'this is a text'}
  commentable { Comment.make }
  person
end

ServiceCategory.blueprint do
  name { Faker::Lorem.words.join ' ' }
end

Country.blueprint do
  name { Faker::Lorem.words.join ' ' }
end

Service.blueprint do
  person
  service_category
  description { Faker::Lorem.words.join ' ' }
  rate { rand(100) }
end

City.blueprint do
  country
  name { Faker::Lorem.words.join ' ' }
end

Badge.blueprint do
  name {Faker::Lorem.words.join ' '} 
  image { File.open("#{Rails.root}/spec/support/images/rails.png") }
end

BadgeOwnership.blueprint do
  badge { Badge.make }
  user { User.make(:person => Person.make) }
  person { Person.make }
  reason { Faker::Lorem.words.join ' ' }
end
