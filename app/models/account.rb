class Account < ApplicationRecord
  has_many :account_updates

  validates :name, presence: true, length: { minimum: 1 }

  # shows currency of transaction (currently set to USD)
end
