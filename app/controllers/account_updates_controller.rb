class AccountUpdatesController < ApplicationController
  def index
    @account_updates = AccountUpdate.all
  end
end
