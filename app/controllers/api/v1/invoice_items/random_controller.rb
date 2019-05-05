class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.all.sample)
  end
end
