class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Customer.find(rel_params[:customer_id]).transactions)
  end

  private

  def rel_params
    params.permit(:customer_id)
  end
end
