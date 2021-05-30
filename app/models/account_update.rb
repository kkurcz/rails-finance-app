require 'net/http'
require 'json'

class AccountUpdate < ApplicationRecord
  belongs_to :account

  validates :balance, presence: true, numericality: { only_integer: true }
  validates :currency, inclusion: { in: ["USD", "EURO", "CNY"] }

  # shows currency of transaction
  # monetize :price_cents
  def convert_currencies
    # Setting URL
    urlUSD = "https://v6.exchangerate-api.com/v6/#{ENV['CURRENCY_API_KEY']}/latest/USD"
    uri = URI(urlUSD)
    responseUSD = Net::HTTP.get(uri)
    response_objUSD = JSON.parse(responseUSD)


    urlCNY = "https://v6.exchangerate-api.com/v6/#{ENV['CURRENCY_API_KEY']}/latest/CNY"
    uri = URI(urlCNY)
    responseCNY = Net::HTTP.get(uri)
    response_objCNY = JSON.parse(responseCNY)


    urlEUR = "https://v6.exchangerate-api.com/v6/#{ENV['CURRENCY_API_KEY']}/latest/EUR"
    uri = URI(urlEUR)
    responseEUR = Net::HTTP.get(uri)
    response_objEUR = JSON.parse(responseEUR)

    # Getting a rate

    usd_euro_rate = response_objUSD['conversion_rates']['EUR']
    usd_cny_rate = response_objUSD['conversion_rates']['CNY']
    euro_usd_rate = response_objEUR['conversion_rates']['USD']
    euro_cny_rate = response_objEUR['conversion_rates']['CNY']
    cny_usd_rate = response_objCNY['conversion_rates']['USD']
    cny_euro_rate = response_objCNY['conversion_rates']['EUR']
    # raise

    # balance = self.balance

    if self.currency == "CNY"
      self.balance_usd = self.balance * cny_usd_rate
      self.balance_euro = self.balance * cny_euro_rate
      self.balance_cny = self.balance
    elsif self.currency == "EURO"
      self.balance_usd = self.balance * euro_usd_rate
      self.balance_euro = self.balance * euro_cny_rate
      self.balance_cny = self.balance
    else
      self.balance_usd = self.balance
      self.balance_euro = self.balance * usd_euro_rate
      self.balance_cny = self.balance  * usd_cny_rate
    end
    self.save
    # raise
  end
end
