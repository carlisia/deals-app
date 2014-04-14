class Merchant < ActiveRecord::Base
  has_many :deals
  has_many :purchasers, through: :purchases, source: :purchaser

  validates :name, presence: true
  validates :address, presence: true

end