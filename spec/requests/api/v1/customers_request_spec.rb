require "rails_helper"

RSpec.describe "Customers API" do
  before :each do
    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
  end

  it "sends a list of customers" do
    get "/api/v1/customers"
    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(1)
  end

  it "can get a single customer by id" do
    id = @cust48.id
    get "/api/v1/customers/#{id}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]
    expect(customer["attributes"]["id"].to_i).to eq(id)
  end

  it "can find customer by id" do
    id = @cust48.id

    get "/api/v1/customers/find?id=#{id}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["attributes"]["id"].to_i).to eq(id)
  end

  it "can find customer by first_name" do
    first_name = @cust48.first_name

    get "/api/v1/customers/find?first_name=#{first_name}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find customer by last_name" do
    last_name = @cust48.last_name

    get "/api/v1/customers/find?last_name=#{last_name}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find customer by created_at" do
    created_at = @cust48.created_at


    get "/api/v1/customers/find?created_at=#{created_at}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]
    expect(customer["attributes"]["id"]).to eq(@cust48.id)
  end

  it "can find customer by updated_at" do
    updated_at = @cust48.updated_at


    get "/api/v1/customers/find?updated_at=#{updated_at}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]
    expect(customer["attributes"]["id"]).to eq(@cust48.id)
  end
end
