class Api::V1::Merchants::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: MerchantSerializer.new(Merchant.find_by(key => value))
  end
end
