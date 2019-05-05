class Api::V1::Items::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: ItemSerializer.new(Item.where(key => value).order(:id).first)
  end

  def index
    key = params.keys.first
    value = params.values.first
    render json: ItemSerializer.new(Item.where(key => value).order(id: :asc))
  end
end
