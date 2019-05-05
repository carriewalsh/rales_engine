class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.find(rel_params[:merchant_id]).items)
  end

  private

  def rel_params
    params.permit(:merchant_id)
  end
end
