class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    total = Merchant.date_revenue(params[:date])/100.0
    render json: {:data => {:attributes => {:total_revenue => total.to_s}}}
  end
end
