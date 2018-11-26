class Agent < ApplicationRecord

  belongs_to :user
  belongs_to :team
  belongs_to :supervised_by, class_name: 'Agent', foreign_key: 'supervised_by_id', required: false
  has_many :dependants, class_name: 'Agent', foreign_key: 'supervised_by_id'
  has_many :sales

  # structure do
  #   associated_at           :string
  #   departed_at             :string

  validates :associated_at, presence: true

  scope :active, -> { where.not(associated_at: nil).where(departed_at: nil) }
  scope :seller, -> { active.where.not(supervised_by_id: nil) }
  scope :boss, -> { active.where(supervised_by_id: nil) }

  def to_s
    full_name
  end

  def full_name
    user&.full_name
  end

  def gender
    user&.gender
  end

  def roles
    return nil unless user&.roles
    roles = user.roles

    roles.length > 1 ? roles : roles.first
  end

end
