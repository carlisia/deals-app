class Deal < ActiveRecord::Base
  belongs_to :merchant
  has_many :purchases

  validates :description, presence: true, uniqueness: { scope: :merchant }
  validates :price, :merchant, presence: true
end