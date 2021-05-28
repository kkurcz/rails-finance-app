class AccountUpdate < ApplicationRecord
  belongs_to :account

  validates :month, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true, numericality: { only_integer: true }
  validates :currency, inclusion: { in: ["USD", "EURO", "CNY"] }

  # shows currency of transaction
  # monetize :price_cents
end
