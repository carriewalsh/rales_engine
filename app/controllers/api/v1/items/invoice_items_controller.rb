class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Item.find(rel_params[:item_id]).invoice_items)
  end

  private

  def rel_params
    params.permit(:item_id)
  end
end
