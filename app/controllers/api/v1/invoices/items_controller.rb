class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Invoice.find(rel_params[:invoice_id]).items)
  end

  private

  def rel_params
    params.permit(:invoice_id)
  end
end
