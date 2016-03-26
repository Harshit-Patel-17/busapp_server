# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.all.length == 0
  puts 'Seeding users...'
  User.create!(email: 'mcs152338@iitd.ac.in', first_name: 'Harshit', last_name: 'Patel', password: 'password')
  User.create!(email: 'mcs152356@iitd.ac.in', first_name: 'Tanuma', last_name: 'Patra', password: 'password')
  User.create!(email: 'mcs152554@iitd.ac.in', first_name: 'Divya', last_name: 'Gautam', password: 'password')
  User.create!(email: 'mcs152360@iitd.ac.in', first_name: 'Yamini', last_name: 'Aggarwal', password: 'password')
end

if Role.all.length == 0
  puts 'Seeding roles...'
  Role.create!(role_name: 'admin')
  Role.create!(role_name: 'conductor')
end

if Privilege.all.length == 0
  puts 'Seeding privileges...'
  users = User.select(:id, :first_name)
  admin_role_id = Role.find_by_role_name('admin')[:id]
  conductor_role_id = Role.find_by_role_name('conductor')[:id]
  users.each do |user|
    if(user[:first_name] == 'Harshit')
      Privilege.create!(user_id: user[:id], role_id: admin_role_id)
    elsif
      Privilege.create!(user_id: user[:id], role_id: conductor_role_id)
    end
  end
end
