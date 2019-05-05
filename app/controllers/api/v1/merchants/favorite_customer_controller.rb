class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.favorite_customer(logic_params[:id]))
  end

  private

  def logic_params
    params.permit(:id)
  end
end
