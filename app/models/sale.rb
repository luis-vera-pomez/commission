class Sale < ApplicationRecord

  belongs_to :product
  belongs_to :agent

  # structure do
  #   quantity                :string
  #   total                   :integer
  #   saled_at                :datetime

  validates :quantity, presence: true
  validates :total, presence: true
  validates :saled_at, presence: true

  def to_s
    "#{product.title} - id"
  end

end
