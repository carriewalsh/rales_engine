class Api::V1::Invoices::CustomerController < ApplicationController
  def index
    render json: CustomerSerializer.new(Invoice.find(rel_params[:invoice_id]).customer)
  end

  private

  def rel_params
    params.permit(:invoice_id)
  end
end
