class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show

    render json: MerchantSerializer.new(Merchant.favorite_merchant(logic_params[:id]))
  end

  private

  def logic_params
    params.permit(:id)
  end
end
