class Api::V1::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(find_params[:id]))
  end

  private

  def find_params
    params.permit(:id)
  end
end
