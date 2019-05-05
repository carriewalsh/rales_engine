class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(logic_params[:quantity]))
  end

  private

  def logic_params
    params.permit(:quantity)
  end
end
