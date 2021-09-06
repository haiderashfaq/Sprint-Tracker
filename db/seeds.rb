# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user = User.create([{ email: 'haider@7vals.com', password: 'haider' }, { email: 'test@test.com', password: '123456' }])

company = Company.create([{ name: '8Vals', subdomain: '8vals', user_id: nil }, { name: '7Vals', subdomain: '7vals', user_id: nil }])
Company.first.issues.create({title: "Issue ", description: "ddd",status: "open", priority: "low", category: "hotfix", estimated_start_date: "2021-08-11", estimated_end_date:"2021-08-04", creator_id: 1})

