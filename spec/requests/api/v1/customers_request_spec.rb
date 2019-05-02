require "rails_helper"

RSpec.describe "Customers API" do
  before :each do
    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie")
    @cust49 = Customer.create(first_name: "Reynold", last_name: "Beed")
    @cust50 = Customer.create(first_name: "Christiano", last_name: "Trighton")
  end

  it "sends a list of customers" do
    get "/api/v1/customers"
    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(3)
  end

  it "can get a single customer by id" do
    id = @cust48.id
    get "/api/v1/customers/#{id}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]
    expect(customer["attributes"]["id"].to_i).to eq(id)
  end
end
