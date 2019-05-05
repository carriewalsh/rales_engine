class Api::V1::Invoices::MerchantController < ApplicationController
  def index
    render json: MerchantSerializer.new(Invoice.find(rel_params[:invoice_id]).merchant)
  end

  private

  def rel_params
    params.permit(:invoice_id)
  end
end
