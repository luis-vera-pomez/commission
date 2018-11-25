class Agent < ApplicationRecord

  belongs_to :user
  belongs_to :team
  belongs_to :supervised_by, class_name: 'Agent', foreign_key: 'supervised_by_id', required: false
  has_many :dependants, class_name: 'Agent', foreign_key: 'supervised_by_id'

  # structure do
  #   associated_at           :string
  #   departed_at             :string

  validates :associated_at, presence: true

end
