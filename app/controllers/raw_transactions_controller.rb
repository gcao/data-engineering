class RawTransactionsController < ApplicationController
  def new
  end

  def index
    redirect_to action: 'new'
  end

  def create
    if not params[:transactions_file]
      flash.alert = 'No transaction file is selected.'
      redirect_to action: 'new'
      return
    end

    transactions = RawTransactionsParseService.new(col_sep: "\t").parse params[:transactions_file].read
    @total = transactions.inject(0) do |total, transaction|
      total += transaction.count * transaction.product.price
    end
  end
end
