class Api::V1::Transactions::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: TransactionSerializer.new(Transaction.find_by(key => value))
  end
end
