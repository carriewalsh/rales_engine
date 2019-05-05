class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params).order(:id).first)
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params).order(id: :asc))
  end

  private

  def search_params
    #add something for unit price here
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
