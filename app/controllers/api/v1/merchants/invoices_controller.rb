class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Merchant.find(rel_params[:merchant_id]).invoices)
  end

  private

  def rel_params
    params.permit(:merchant_id)
  end
end
