class AddBalanceUsdToAccountUpdates < ActiveRecord::Migration[6.0]
  def change
    add_column :account_updates, :balance_usd, :integer
  end
end
