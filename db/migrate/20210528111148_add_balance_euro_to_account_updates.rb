class AddBalanceEuroToAccountUpdates < ActiveRecord::Migration[6.0]
  def change
    add_column :account_updates, :balance_euro, :integer
  end
end
