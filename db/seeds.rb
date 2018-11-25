# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Product.destroy_all
Team.destroy_all

User.create!(email: 'admin@company.com', first_name: 'Admin', last_name: 'User', gender: User::MALE, phone: '111-111-1111', cell: '999-999-9999', roles: [:admin], password: '123456')

Product.create!(title: 'Life', price: 2000)
Product.create!(title: 'House', price: 1800)
Product.create!(title: 'Car', price: 500)
Product.create!(title: 'Health', price: 1100)

Team.create!(title: 'General Insurance Team', description: nil, location: 'North')
Team.create!(title: 'General Insurance Team', description: nil, location: 'South')
Team.create!(title: 'General Insurance Team', description: nil, location: 'East')
Team.create!(title: 'General Insurance Team', description: nil, location: 'West')
