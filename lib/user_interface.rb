require 'httparty'

class UserInterface
  include HTTParty
  base_uri "https://randomuser.me/"

  def initialize(team:, quantity:, gender:)
    @team = team
    @quantity = quantity
    @gender = gender
  end

  def get_users
  	conditions = "results=#{@quantity}" # Quantity of users
  	conditions += "&gender=#{@gender.strip.downcase}" # Gender of users
  	conditions += "&password=upper,lower,6-8" # Password conditions
  	conditions += "&nat=ca,us" # Nationality of users

    self.class.get("/api/?#{conditions}")
  end

  def generate_users
    users = get_users['results']

    users.each do |user|
      new_user = User.create!(
        first_name: user['name']['first'].capitalize,
        last_name: user['name']['last'].capitalize,
        email: user['email'],
        gender: ( user['gender'] == 'male' ? User::MALE : User::FEMALE ),
        phone: user['phone'],
        cell: user['cell'],
        password: '123456', # user['login']['password'], # Assign all new users the same password for testing purposes
        roles: [:agent]
      )

      Agent.create!(team_id: @team.id, user_id: new_user.id, associated_at: Time.zone.now)
    end
  end

end