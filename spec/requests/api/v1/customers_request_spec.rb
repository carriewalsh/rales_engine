require "rails_helper"

RSpec.describe "Customers API" do
  before :each do
    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @cust49 = Customer.create(first_name: "Trixie", last_name: "Beed", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @cust50 = Customer.create(first_name: "Christiano", last_name: "Beed", created_at: "2012-04-24T14:14:14.000Z",updated_at: "2012-04-24T14:14:14.000Z")
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

  context "find" do
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

  context "Find All" do
    it "can find all customers by first_name" do
      first_name = @cust48.first_name

      get "/api/v1/customers/find_all?first_name=#{first_name}"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
      expect(customers.first["attributes"]["first_name"]).to eq(first_name)
      expect(customers.count).to eq(2)
    end

    it "can find all customers by last_name" do
      last_name = @cust49.last_name

      get "/api/v1/customers/find_all?last_name=#{last_name}"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
      expect(customers.first["attributes"]["last_name"]).to eq(last_name)
      expect(customers.count).to eq(2)
    end

    it "can find all customers by created_at" do
      created_at = @cust48.created_at


      get "/api/v1/customers/find_all?created_at=#{created_at}"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
      expect(customers.first["attributes"]["id"]).to eq(@cust48.id)
      expect(customers.count).to eq(2)
    end

    it "can find all customers by updated_at" do
      updated_at = @cust48.updated_at


      get "/api/v1/customers/find_all?updated_at=#{updated_at}"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
      expect(customers.first["attributes"]["id"]).to eq(@cust48.id)
    end
  end

  it "can find a random customer" do
    get "/api/v1/customers/random"
    expect(response).to be_successful

    rando = JSON.parse(response.body)
    expect(rando["data"].class).to eq(Hash)
    expect(rando["data"]["attributes"]).to be_present
    expect(rando.count).to eq(1)
  end
end
