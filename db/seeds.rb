# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
<<<<<<< HEAD

# 2.7.1 :009 > for i in 0..100
# 2.7.1 :010 > name = Faker::Name.name
# 2.7.1 :011 > User.create!(name: name, phone_num:'123456',role_id:'1', email: "ha
# ider#{i+100}@8vals.com", password: 'haider', company_id: 1)
# 2.7.1 :012 > end
=======
>>>>>>> 1048431b6413ddfccef4e25a1adbdcbcd11dfd42

Company.create([{ name: '8Vals', subdomain: '8vals', owner_id: nil },
                { name: '7Vals', subdomain: '7vals', owner_id: nil }])
Company.current_company_id = 1

<<<<<<< HEAD

=======
user = User.create!(email: 'haider@8vals.com', password: '123456', role_id: 1)
Company.current_company.update(owner: user)
(0..100).each do |i|
  User.create!(email: "haider#{i}@8vals.com", password: '123456', role_id: 2)
end
>>>>>>> 1048431b6413ddfccef4e25a1adbdcbcd11dfd42
