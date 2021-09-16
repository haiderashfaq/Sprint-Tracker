# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.create([{ name: '8Vals', subdomain: '8vals', owner_id: nil },
                { name: '7Vals', subdomain: '7vals', owner_id: nil }])
Company.current_company_id = 1

user = User.create!(email: 'haider@8vals.com', password: '123456', role_id: 1)
Company.current_company.update(owner: user)
(0..100).each do |i|
  User.create!(email: "haider#{i}@8vals.com", password: '123456', role_id: 2)
end
