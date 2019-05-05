class Api::V1::Invoices::CustomerController < ApplicationController
  def index
    render json: CustomerSerializer.new(Invoice.find(params[:invoice_id]).customer)
  end
end
