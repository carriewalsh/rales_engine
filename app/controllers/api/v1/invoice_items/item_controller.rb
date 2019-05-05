class Api::V1::InvoiceItems::ItemController < ApplicationController
  def index
    render json: ItemSerializer.new(InvoiceItem.find(rel_params[:invoice_item_id]).item)
  end

  private

  def rel_params
    params.permit(:invoice_item_id)
  end
end
