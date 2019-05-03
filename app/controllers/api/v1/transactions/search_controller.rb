class Api::V1::Transactions::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: TransactionSerializer.new(Transaction.find_by(key => value))
  end

  def index
    key = params.keys.first
    value = params.values.first
    transactions = Transaction.where(key => value)
    render json: TransactionSerializer.new(transactions.order(id: :asc))
  end
end

# find by invoice_id in order
