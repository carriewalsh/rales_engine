class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def index
    render json: InvoiceSerializer.new(InvoiceItem.find(params[:invoice_item_id]).invoice)
  end
end
