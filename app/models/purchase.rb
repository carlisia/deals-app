class Purchase < ActiveRecord::Base
  belongs_to :purchaser
  belongs_to :deal
  has_one :merchant, through: :deal

  validates :purchaser, :deal, presence: true
  validates :count, presence: true, numericality: { greater_than: 0, only_integer: true }
end