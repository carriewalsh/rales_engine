class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params[:date] && params[:id]
      total = Merchant.find(params[:id]).date_revenue(params[:date])
      term = :revenue
    elsif params[:date]
      total = Merchant.date_revenue(params[:date])
      term = :total_revenue
    else
      total = Merchant.find(params[:id]).total_revenue
      term = :revenue
    end
    render json: {:data => {:attributes => {term => (total/100.0).to_s}}}
  end

  private

  def logic_params
    params.permit(:date, :id)
  end
end
