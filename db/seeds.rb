# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# STATUS = { 1 => 'Open', 2 => "In Progress", 3 => 'Resolved', 4 => 'Closed'}.freeze

# Company.create([{ name: '90Vals', subdomain: '90vals', owner_id: nil },
#                 { name: '7Vals', subdomain: '7vals', owner_id: nil }])
# Company.current_company_id = 1

# owner = User.create!(email: 'zain@gmail.com', password: '123456', role_id: 1, phone_num: "123456", name: "haider")
# Company.current_company.update(owner: owner)

# (0..100).each do |i|
#   val = Faker::Company.name
#   company = Company.create!(name: val, subdomain: val, owner_id: nil)
#   company.update(owner: owner)
#   c = Company.unscoped.all
#   user = User.create!(email: "haider#{i}@8vals.com", password: '123456', role_id: 2, phone_num: "1233456#{i}}", name: Faker::Name.name, company: c[rand(0..i)])
# end

# u = User.unscoped.all

# (1..100).each do |i|
#   Project.create!(name: Faker::Company.name, start_date: Time.now, end_date: 5.day.from_now, manager: u[rand(1..100)], creator: u[rand(1..100)], company_id: rand(1..100))
# end

# (0..5000).each do |i|
#   user = u[rand(1..100)]
#   Issue.create!(title: Faker::Company.name, description: Faker::Quote.matz, estimated_time: "100.00", status: STATUS[rand(1..4)], priority: "High", category: "Hotfix",
#    company_id: user.company_id, estimated_start_date: Time.now, estimated_end_date: 5.day.from_now,  creator: user, assignee: u[rand(1..100)], reviewer_id: rand(1..100), project_id: rand(1..100))
# end

c = Company.all
u = User.unscoped.all
p = Project.unscoped.all
(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(1..15).days.ago,
    end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-15..0).days.ago,
    end_date: rand(-30..-16).days.ago, estimated_start_date: rand(-15..0).days.ago, estimated_end_date: rand(-30..-16).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-29..-16).days.ago,
    end_date: rand(-45..-30).days.ago, estimated_start_date: rand(-29..-16).days.ago, estimated_end_date: rand(-45..-30).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-44..-29).days.ago,
    end_date: rand(-60..-45).days.ago, estimated_start_date: rand(-44..-29).days.ago, estimated_end_date: rand(-60..-45).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-59..-44).days.ago,
    end_date: rand(-75..-60).days.ago, estimated_start_date: rand(-59..-44).days.ago, estimated_end_date: rand(-75..-60).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-74..-59).days.ago,
    end_date: rand(-90..-75).days.ago, estimated_start_date: rand(-74..-59).days.ago, estimated_end_date: rand(-90..-75).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(30..44).days.ago,
    end_date: rand(15..29).days.ago, estimated_start_date: rand(30..44).days.ago, estimated_end_date: rand(15..29).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(60..74).days.ago,
    end_date: rand(45..59).days.ago, estimated_start_date: rand(60..74).days.ago, estimated_end_date: rand(45..59).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(90..104).days.ago,
    end_date: rand(75..89).days.ago, estimated_start_date: rand(90..104).days.ago, estimated_end_date: rand(75..89).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry

(0..1000).each do |i|
  user = u[rand(1..100)]
  Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(120..134).days.ago,
    end_date: rand(105..119).days.ago, estimated_start_date: rand(120..134).days.ago, estimated_end_date: rand(105..119).days.ago,
    project: p[rand(0..99)], company: c[rand(0..100)], creator: user)
end

binding.pry




