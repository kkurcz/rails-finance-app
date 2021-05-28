class AccountsController < ApplicationController
  before_action :set_account, only: [:show] #:edit, :update, :destroy]

  def index
    @accounts = Account.all
    @account_updates = AccountUpdate.all

    # @wallets = policy_scope(Wallet).order(created_at: :desc)

    # show recent transactions on users homepage
    # @transactions = policy_scope(Transaction).where(sender_wallet: @wallets).order(created_at: :desc)
  end

  def show
    # show all transactions of a given wallet
    @account_updates = AccountUpdate.where(account_id: @account.id).order(created_at: :desc)
    # @account_updates = policy_scope(Transaction).where(sender_wallet: @wallet.id).order(created_at: :desc)
  end

  private
  def set_account
    @account = Account.find(params[:id])
    # authorize @wallet
  end

  def account_params
    params.require(:account).permit(:name)
  end
end

