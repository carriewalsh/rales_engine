class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.top_by_revenue(logic_params[:quantity]))
  end

  private

  def logic_params
    params.permit(:quantity)
  end
end
