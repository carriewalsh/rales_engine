class Api::V1::InvoiceItems::ItemController < ApplicationController
  def index
    render json: ItemSerializer.new(InvoiceItem.find(params[:invoice_item_id]).item)
  end
end
