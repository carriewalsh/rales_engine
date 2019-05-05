class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Customer.find(rel_params[:customer_id]).invoices)
  end

  private

  def rel_params
    params.permit(:customer_id)
  end
end
