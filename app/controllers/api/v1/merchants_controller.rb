class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(find_params[:id]))
    #add search_by to the model for this
  end

  private

  def find_params
    params.permit(:id)
  end
end
