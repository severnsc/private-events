99.times do |n|
	User.create!(name: Faker::Name.name,
				email: "example-#{n+1}@gmail.com",
				password: "password",
				password_confirmation: "password")
end