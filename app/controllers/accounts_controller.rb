class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    # @accounts = Account.all
    @account_updates = policy_scope(AccountUpdate).order(created_at: :desc)

    @accounts = policy_scope(Account).order(created_at: :asc)

    @total_usd = 0
    @total_cny = 0
    @total_euro = 0

    @accounts.each do |account|
      if AccountUpdate.where(account_id: account.id).all.count > 0 && AccountUpdate.where(account_id: account.id).last.balance_usd != nil
        @total_usd += AccountUpdate.where(account_id: account.id).last.balance_usd
        @total_cny += AccountUpdate.where(account_id: account.id).last.balance_cny
        @total_euro += AccountUpdate.where(account_id: account.id).last.balance_euro
      end
    end

    # policy_scope(AccountUpdate).each do |au|
    #   @total_usd += au.balance_usd
    #   @total_cny += au.balance_cny
    #   @total_euro += au.balance_euro
    # end
    # show recent transactions on users homepage
    # @transactions = policy_scope(Transaction).where(sender_account: @accounts).order(created_at: :desc)
  end

  def show
    # show all transactions of a given account
    @account_updates = policy_scope(AccountUpdate).where(account_id: @account.id).order(created_at: :desc)
    # @account_updates = policy_scope(Transaction).where(sender_account: @account.id).order(created_at: :desc)
  end

  def new
    @account = Account.new
    authorize @account
  end

  # GET /account/1/edit
  def edit
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.user_id = current_user.id
    authorize @account

    if @account.save
      redirect_to root_path, notice: 'account was created.'
    else
      render :new
    end
  end

  # PATCH/PUT /walles/1
  def update
    if @account.update(account_params)
      redirect_to @account, notic: 'account was updated.'
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'account was deleted.'
  end

  private
  def set_account
    @account = Account.find(params[:id])
    authorize @account
  end

  def account_params
    params.require(:account).permit(:name)
  end
end

