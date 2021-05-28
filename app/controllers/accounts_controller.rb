class AccountsController < ApplicationController
  def index
    @accounts = Account.all
    @account_updates = AccountUpdate.all

    # @wallets = policy_scope(Wallet).order(created_at: :desc)

    # show recent transactions on users homepage
    # @transactions = policy_scope(Transaction).where(sender_wallet: @wallets).order(created_at: :desc)
  end
end
