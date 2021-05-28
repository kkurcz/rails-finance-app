class AccountUpdate < ApplicationRecord
  belongs_to :account

  validates :balance, presence: true, numericality: { only_integer: true }
  validates :currency, inclusion: { in: ["USD", "EURO", "CNY"] }

  # shows currency of transaction
  # monetize :price_cents
  def convert_currencies
    usd_euro_rate = 0.8
    usd_cny_rate = 6.6
    euro_usd_rate = 1.2
    euro_cny_rate = 7.6
    cny_usd_rate = 0.18
    cny_euro_rate = 0.13

    balance = self.balance

    if self.currency == "CNY"
      self.balance_usd = balance * cny_usd_rate
      self.balance_euro = balance * cny_euro_rate
      self.balance_cny = balance
    elsif self.currency == "EURO"
      self.balance_usd = balance * euro_usd_rate
      self.balance_euro = balance * euro_cny_rate
      self.balance_cny = balance
    else
      self.balance_usd = balance
      self.balance_euro = balance * usd_euro_rate
      self.balance_cny = balance  * user_cny_rate
    end
    self.save
  end
end
