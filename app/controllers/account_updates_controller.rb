class AccountUpdatesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_account_update, only: [:show, :edit, :update, :destroy]
  def index
    @account_updates = AccountUpdate.all
  end

  def show
  # maybe use for later
  end

  def new
    # @accounts is only needed for frontend simple_form transfers ui
    @accounts = Account.all
    @account = Account.find(params[:account_id])
    @account_update = AccountUpdate.new
    authorize @account_update
  end

  # GET /account_update/1/edit
  def edit
  end

  # POST /account_updates
  def create

    @account_update = AccountUpdate.new(account_update_params)
    @account = Account.find(params[:account_id])
    @account_update.account_id = @account.id
    # raise
    authorize @account_update
    if @account_update.save
      @account_update.convert_currencies
      redirect_to root_path, notice: 'account_update was created.'
    else
      # flash[:alert] = "Please check that you have sufficient funds in this account and all information is correct."
      render :new
    end
  end

    # PATCH/PUT /walles/1
  def update
    if @account_update.update(account_params)
      redirect_to @account, notic: 'update was updated.'
    else
      render :edit
    end
  end

  def destroy
    @account_update.destroy
    redirect_to accounts_url, notice: 'update was deleted.'
  end

  private
  def set_account_update
    @account_update = AccountUpdate.find(params[:id])
    authorize @account_update
  end

  def account_update_params
    params.require(:account_update).permit(:balance, :currency)
  end
end
