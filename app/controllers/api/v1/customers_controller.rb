class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(find_params[:id]))
  end

  private

  def find_params
    params.permit(:id)
  end
end
