class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_items(logic_params[:quantity]))
  end

  private

  def logic_params
    params.permit(:quantity)
  end
end
