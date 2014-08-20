# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "------------------Users------------------"
user1 = User.new do |user|
	user.first_name = :User
	user.last_name = 1
	user.password = 123456789
	user.email = '1@user.com'
	user.user_name = "user1"
	user.skip_confirmation!
	user.save!
end
user2 = User.new do |user|
	user.first_name = :User
	user.last_name = 2
	user.password = 123456789
	user.email = '2@user.com'
	user.user_name = "user2"
	user.skip_confirmation!
	user.save!
end
user3 = User.new do |user|
	user.first_name = :User
	user.last_name = 3
	user.password = 123456789
	user.email = '3@user.com'
	user.user_name = "user3"
	user.skip_confirmation!
	user.save!
end
puts "------------------Debts------------------"
debt1 = Debt.new do |debt|
	debt.amount = 10
	debt.remaining = 5
	debt.creditor = user1
	debt.debtor = user2
	debt.skip_confirmation!
	debt.save!
end
debt2 = Debt.new do |debt|
	debt.amount = 30
	debt.creditor = user1
	debt.debtor = user3
	debt.save!
end
debt3 = Debt.new do |debt|
	debt.amount = 40
	debt.creditor = user2
	debt.debtor = user1
	debt.save!
end
debt4 = Debt.new do |debt|
	debt.amount = 50
	debt.remaining = 10
	debt.creditor = user2
	debt.debtor = user3
	debt.skip_confirmation!
	debt.save!
end
debt5 = Debt.new do |debt|
	debt.amount = 100
	debt.creditor = user3
	debt.debtor = user1
	debt.skip_confirmation!
	debt.save!
end
debt6 = Debt.new do |debt|
	debt.amount = 20
	debt.remaining = 15
	debt.creditor = user3
	debt.debtor = user2
	debt.skip_confirmation!
	debt.save!
end