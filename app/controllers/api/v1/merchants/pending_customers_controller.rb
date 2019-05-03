class Api::V1::Merchants::PendingCustomersController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.pending_customers(params[:id]))
  end
end
