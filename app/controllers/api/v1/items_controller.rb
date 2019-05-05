class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(find_params[:id]))
  end

  private

  def find_params
    params.permit(:id)
  end
end
