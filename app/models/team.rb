class Team < ApplicationRecord

  has_many :agents
  
  # structure do
  #   title                   :string
  #   description             :string
  #   location                :string
  #   timestamps

  NORTH = 'North'
  SOUTH = 'South'
  EAST = 'East'
  WEST = 'West'

  LOCATIONS = [NORTH, SOUTH, EAST, WEST]

  validates :title, presence: true
  validates :location, presence: true

  def supervisors
    agents.boss.length
  end

  def sellers
    agents.seller.length
  end

  def sales_per_user(user_id:)
    agents.where(user_id: user_id).sum { |agent| agent.sales.length }
  end

end