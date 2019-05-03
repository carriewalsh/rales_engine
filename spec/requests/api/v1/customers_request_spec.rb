require "rails_helper"

RSpec.describe "Customers API" do
  before :each do
    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @cust49 = Customer.create(first_name: "Trixie", last_name: "Beed", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @cust50 = Customer.create(first_name: "Christiano", last_name: "Beed", created_at: "2012-04-24T14:14:14.000Z",updated_at: "2012-04-24T14:14:14.000Z")

    @merch1 = Merchant.create(name: "Ondrea Chadburn")
    @merch2 = Merchant.create(name: "Raff Faust")
    @merch3 = Merchant.create(name: "Con Chilver")

    @item1 = @merch1.items.create(name: "W.L. Weller Special Reserve",unit_price: 20000, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.")
    @item2 = @merch2.items.create(name: "W.L. Weller C.Y.P.B.",unit_price: 35000, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.")
    @item3 = @merch3.items.create(name: "Bulleit Bourbon",unit_price: 22000, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.")

    @invoice1 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @invoice2 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @invoice3 = @merch2.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @invoice4 = @merch3.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")

    @cust48.invoices << @invoice1
    @cust49.invoices << @invoice2
    @cust48.invoices << @invoice3
    @cust50.invoices << @invoice4

    @ii1 = @item1.invoice_items.create(quantity: 10, unit_price: 20000, created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @ii2 = @item2.invoice_items.create(quantity: 10, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii3 = @item3.invoice_items.create(quantity: 1, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")
    @ii4 = @item2.invoice_items.create(quantity: 10, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii5 = @item3.invoice_items.create(quantity: 1, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")

    @invoice1.invoice_items << @ii1
    @invoice1.invoice_items << @ii2
    @invoice2.invoice_items << @ii3
    @invoice3.invoice_items << @ii4
    @invoice4.invoice_items << @ii5

    @t1 = @invoice1.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
    @t2 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed")
    @t3 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
    @t4 = @invoice3.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
    @t5 = @invoice4.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed")
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

    it "can find a random customer" do
      get "/api/v1/customers/random"
      expect(response).to be_successful

      rando = JSON.parse(response.body)
      expect(rando["data"].class).to eq(Hash)
      expect(rando["data"]["attributes"]).to be_present
      expect(rando.count).to eq(1)
    end
  end
  context "Customers Logic" do
    it "can send a favorite merchant for a customer " do
      get "/api/v1/customers/#{@cust48.id}/favorite_merchant"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)["data"]
      expect(merchant["attributes"]["name"]).to eq("#{@merch1.name}")

    end
  end
end
