class Api::V1::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.all)
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(find_params[:id]))
  end

  private

  def find_params
    params.permit(:id)
  end
end
