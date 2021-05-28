class CreateAccountUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :account_updates do |t|
      t.integer :balance
      t.string :currency
      t.timestamps
    end
  end
end
