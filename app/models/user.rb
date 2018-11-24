class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_role_restricted

  # structure do
  #   first_name              :string
  #   last_name               :string
  #   email                   :string
  #   archived                :boolean

  validates :encrypted_password, presence: true
  validates :first_name, presence: true, if: -> { persisted? }
  validates :last_name, presence: true, if: -> { persisted? }

  def full_name
    return email if first_name.blank? || last_name.blank?
    "#{first_name} #{last_name}"
  end

end
