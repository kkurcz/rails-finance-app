class CreateAccountUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :account_updates do |t|

      t.timestamps
    end
  end
end
