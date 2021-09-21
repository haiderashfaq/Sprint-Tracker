STATUS = { 1 => 'Open', 2 => "In Progress", 3 => 'Resolved', 4 => 'Closed'}.freeze

VALID_STATUSES = { 1 => 'Planning', 2 => 'Active', 3 => 'Closed'}.freeze

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

# (1..100).each do |i|
#   company = rand(1..100)
#   Company.current_company_id = company
#   u = User.all
#   unless u.blank?
#     Project.create!(name: Faker::Company.name, start_date: Time.now, end_date: 5.day.from_now, manager: u[rand(1..u.count)-1], creator: u[rand(1..u.count)-1], company_id: company)
#   end
# end

(1..100).each do |i|
  Company.current_company_id = i
  u = User.all
  p = Project.all
  unless p.blank?
    user = u[rand(1..u.count)-1]
    unless user.blank? and u.blank?
      issue = Issue.create!(title: Faker::Company.name, description: Faker::Quote.matz, estimated_time: "100.00", status: STATUS[rand(1..4)], priority: "High", category: "Hotfix", actual_start_date: rand(1..15).days.ago, actual_end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,  creator: user, assignee_id: u[rand(1..u.count)-1].id, reviewer_id: u[rand(1..u.count)-1].id, project: p[rand(1..p.count)-1])

      (0..rand(1..10)).each do |i|
        user = u[rand(1..u.count)-1]
        TimeLog.create!(date: rand(1..15).days.ago, logged_time: Faker::Number.between(from: 0.0, to: 100.0).round(2) , work_description: Faker::Quote.matz, assignee: user, issue:issue)

      end
      # pu = ProjectsUser.new(project: p[rand(1..p.count)-1], user: u[rand(1..u.count)-1])
      # pu.save(validate: false)
    end
  end
end