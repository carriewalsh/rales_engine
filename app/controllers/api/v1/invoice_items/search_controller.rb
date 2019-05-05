class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(key => value))
  end

  def index
    key = params.keys.first
    value = params.values.first
    render json: InvoiceItemSerializer.new(InvoiceItem.where(key => value))
  end
end
