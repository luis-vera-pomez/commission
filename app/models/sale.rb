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

  before_save do
    if new_record?
      self.policy = product.title.upcase[0..1] + ( "%05d" % rand(1..1000) )
    end
  end

  def to_s
    "#{product.title} - id"
  end

end
