require 'httparty'

class UserInterface
  include HTTParty
  base_uri "https://randomuser.me/"

  def initialize(quantity:, gender:)
    @quantity = quantity
    @gender = gender
  end

  def get_users
    self.class.get("/api/?results=#{@quantity}&gender=#{@gender}")
  end

  def generate_users
    new_users = get_users['results']

    new_users.each do |user|
      User.create!(
        first_name: user['name']['first'],
        last_name: user['name']['last'],
        gender: user['gender'],
        phone: user['phone'],
        cell: user['cell']
      )
    end
  end

end

# user_interface = UserInterface.new(quantity: 1, gender: 'female')
# user_interface.generate_users

# user_interface.users.each do |user|
#   binding.pry
# end

# user['results'].first['name']['last'].capitalize