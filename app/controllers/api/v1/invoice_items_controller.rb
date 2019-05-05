class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(find_params[:id]))
  end

  private

  def find_params
    params.permit(:id)
  end
end
