def staff
  @staff ||= {}
end

def staff_with_key key
  raise "No staff member with that name" unless staff[key]
  staff[key] 
end

Given /^a staff member named "([^\"]*)"$/ do |first_name|
  staff[first_name] = Person.make(:first_name => first_name) 
end
