class Api::V1::Customers::SearchController < ApplicationController
  def show
    key = params.keys.first
    value = params.values.first
    render json: CustomerSerializer.new(Customer.find_by(key => value))
  end
end
