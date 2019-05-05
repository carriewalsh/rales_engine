class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Invoice.find(rel_params[:invoice_id]).transactions)
  end

  private

  def rel_params
    params.permit(:invoice_id)
  end
end
