class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: InvoiceItemSerializer.new(InvoiceItem.where(key => value).order(:id).first)
  end

  def index
    key = params.keys.first
    value = params.values.first
    render json: InvoiceItemSerializer.new(InvoiceItem.where(key => value).order(id: :asc))
  end
end
