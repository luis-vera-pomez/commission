class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # structure do
  #   first_name              :string
  #   last_name               :string
  #   email                   :string
  #   archived                :boolean

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

end
