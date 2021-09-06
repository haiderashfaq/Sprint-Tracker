# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company = Company.create([{ name: '8Vals', subdomain: '8vals', owner_id: nil },
                          { name: '7Vals', subdomain: '7vals', owner_id: nil }])

# user = User.create([{ email: 'haider@8vals.com', password: '123456', role_id: 1, company_id: company },
#                     { email: 'adnan@8vals.com', password: '123456', role_id: 2, company_id: company },
#                     { email: 'zain@8vals.com', password: '123456', role_id: 2, company_id: company },
#                     { email: 'bakz@8vals.com', password: '123456', role_id: 2, company_id: company },
#                     { email: 'tommy@7vals.com', password: '123456', role_id: 1, company_id: 2 }])
