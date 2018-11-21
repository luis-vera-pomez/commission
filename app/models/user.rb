class User < ApplicationRecord

  # structure do
  #   first_name              :string
  #   last_name               :string
  #   email                   :string
  #   archived                :boolean

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

end
