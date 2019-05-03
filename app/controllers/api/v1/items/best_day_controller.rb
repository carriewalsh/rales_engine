class Api::V1::Items::BestDayController < ApplicationController
  def show
    date = Item.find(params[:id]).best_date.date.to_s.to_date
    render json: {"data" => {"attributes" => {"best_day" => date}}}
  end
end
