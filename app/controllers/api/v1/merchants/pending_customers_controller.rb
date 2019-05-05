class Api::V1::Merchants::PendingCustomersController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.pending_customers(logic_params[:id]))
  end

  private

  def logic_params
    params.permit(:id)
  end
end
