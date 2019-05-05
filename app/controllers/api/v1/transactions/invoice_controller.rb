class Api::V1::Transactions::InvoiceController < ApplicationController
  def index
    invoice_id = Transaction.find(params[:transaction_id]).invoice_id
    render json: InvoiceSerializer.new(Invoice.find(invoice_id))
  end
end
