class AccountUpdate < ApplicationRecord
  def index
    @account_updates = AccountUpdate.all
  end
end
