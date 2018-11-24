class Product < ApplicationRecord

  # structure do
  #   title              :string
  #   proce              :integer

  validates :title, presence: true
  validates :price, presence: true

end
