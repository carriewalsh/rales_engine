class Api::V1::Items::MerchantController < ApplicationController
  def index
    render json: MerchantSerializer.new(Item.find(rel_params[:item_id]).merchant)
  end

  private

  def rel_params
    params.permit(:item_id)
  end
end
