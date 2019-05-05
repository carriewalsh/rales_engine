class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(search_params).order(id: :asc))
  end

  private

  def search_params
    params.permit(:id, :merchant_id, :customer_id, :status, :created_at, :updated_at)
  end
end
