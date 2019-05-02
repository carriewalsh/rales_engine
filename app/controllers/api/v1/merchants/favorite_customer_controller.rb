class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Merchant.favorite_merchant(params[:merchant_id]))
  end
end
