class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def index
    render json: InvoiceSerializer.new(InvoiceItem.find(rel_params[:invoice_item_id]).invoice)
  end

  private

  def rel_params
    params.permit(:invoice_item_id)
  end
end
