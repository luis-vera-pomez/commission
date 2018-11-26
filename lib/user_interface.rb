require 'httparty'

class UserInterface
  include HTTParty
  base_uri "https://randomuser.me/"

  def initialize(team:, quantity:, role:, gender: nil, supervised_by: nil)
    @team = team
    @quantity = quantity
    @role = role
    @gender = gender
    @supervised_by = supervised_by
  end

  def get_users
  	conditions = "results=#{@quantity}" # Quantity of users
  	conditions += "&gender=#{@gender.strip.downcase}" if @gender.present? # Gender of users
  	conditions += "&password=upper,lower,6-8" # Password conditions
  	conditions += "&nat=ca,us" # Nationality of users

    self.class.get("/api/?#{conditions}")
  end

  def generate_users
    users = get_users['results']

    users.each do |user|
      next if User.find_by_email(user['email'])

      new_user = User.create!(
        first_name: user['name']['first'].capitalize,
        last_name: user['name']['last'].capitalize,
        email: user['email'],
        gender: ( user['gender'] == 'male' ? User::MALE : User::FEMALE ),
        phone: user['phone'],
        cell: user['cell'],
        password: '123456', # user['login']['password'], # Assign all new users the same password for testing purposes
        roles: [@role]
      )

      Agent.create!(team_id: @team.id, user_id: new_user.id, supervised_by: @supervised_by, associated_at: Time.zone.now)
    end
  end

end