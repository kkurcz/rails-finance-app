class AccountsController < ApplicationController
  before_action :set_account, only: [:show] #:edit, :update, :destroy]

  def index
    @accounts = Account.all
    @account_updates = AccountUpdate.all

    # @accounts = policy_scope(account).order(created_at: :desc)

    # show recent transactions on users homepage
    # @transactions = policy_scope(Transaction).where(sender_account: @accounts).order(created_at: :desc)
  end

  def show
    # show all transactions of a given account
    @account_updates = AccountUpdate.where(account_id: @account.id).order(created_at: :desc)
    # @account_updates = policy_scope(Transaction).where(sender_account: @account.id).order(created_at: :desc)
  end

  def new
    @account = Account.new
    # authorize @account
  end

  # GET /account/1/edit
  def edit
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.user = current_user
    authorize @account

    if @account.save
      redirect_to @account, notice: 'account was created.'
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
    # authorize @account
  end

  def account_params
    params.require(:account).permit(:name)
  end
end

