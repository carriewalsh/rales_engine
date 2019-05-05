class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Invoice.find(rel_params[:invoice_id]).invoice_items)
  end

  private

  def rel_params
    params.permit(:invoice_id)
  end
end
