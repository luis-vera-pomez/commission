class Product < ApplicationRecord

  has_many :sales

  # structure do
  #   title              :string
  #   proce              :integer

  validates :title, presence: true
  validates :price, presence: true

  def to_s
    title
  end

end
