require 'faker'

puts "clearing records"

User.destroy_all

puts "generating users and profiles"

n = 1
10.times do
	u =	User.create(email: "yopmail#{n}@gmail.com", password: "blabla")
	u.user_profile.update(username: Faker::ProgrammingLanguage.unique.name)
	n += 1
end

puts "#{User.count} users generated"
