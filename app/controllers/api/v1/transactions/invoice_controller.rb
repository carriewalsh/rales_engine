class Api::V1::Transactions::InvoiceController < ApplicationController
  def index
    invoice_id = Transaction.find(rel_params[:transaction_id]).invoice_id
    render json: InvoiceSerializer.new(Invoice.find(invoice_id))
  end

  private

  def rel_params
    params.permit(:transaction_id)
  end
end
