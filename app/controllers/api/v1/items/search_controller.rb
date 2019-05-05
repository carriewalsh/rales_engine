class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.where(search_params).order(:id).first)
  end

  def index
    render json: ItemSerializer.new(Item.where(search_params).order(id: :asc))
  end

  private

  def search_params
    if params[:unit_price] && params[:unit_price].include?(".")
      params[:unit_price] = (params[:unit_price].to_f*100).round(2)
    end
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
