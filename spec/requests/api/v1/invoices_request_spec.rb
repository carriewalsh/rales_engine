require "rails_helper"

RSpec.describe "Invoices API" do
  before :each do
    @merch1 = Merchant.create(name: "Ondrea Chadburn")
    @merch2 = Merchant.create(name: "Raff Faust")
    @merch3 = Merchant.create(name: "Con Chilver")
    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie")
    @cust49 = Customer.create(first_name: "Reynold", last_name: "Beed")
    @cust50 = Customer.create(first_name: "Christiano", last_name: "Trighton")

    @item1 = @merch1.items.create(name: "W.L. Weller Special Reserve",unit_price: 20000, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.")
    @item2 = @merch2.items.create(name: "W.L. Weller C.Y.P.B.",unit_price: 35000, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.")
    @item3 = @merch3.items.create(name: "Bulleit Bourbon",unit_price: 22000, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.")

    @invoice1 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @invoice2 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")

    @cust48.invoices << @invoice1
    @cust49.invoices << @invoice2

    @ii1 = @item1.invoice_items.create(quantity: 10, unit_price: 20000, created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @ii2 = @item2.invoice_items.create(quantity: 10, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii3 = @item3.invoice_items.create(quantity: 10, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")

    @invoice1.invoice_items << @ii1
    @invoice1.invoice_items << @ii2
    @invoice2.invoice_items << @ii3

    @t1 = @invoice1.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @t2 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @t3 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
  end

  it "sends a list of invoices" do
    get "/api/v1/invoices"
    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(2)
  end

  it "sends a single invoice by id" do
    get "/api/v1/invoices/#{@invoice1.id}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(@invoice1.id.to_s)
  end

  context "Find" do
    it "can find a invoice by id" do
      id = @invoice1.id

      get "/api/v1/invoices/find?id=#{id}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find a invoice by customer_id" do
      customer_id = @invoice1.customer_id

      get "/api/v1/invoices/find?customer_id=#{customer_id}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find a invoice by merchant_id" do
      merchant_id = @invoice1.merchant_id

      get "/api/v1/invoices/find?merchant_id=#{merchant_id}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find a invoice by status" do
      status = @invoice1.status

      get "/api/v1/invoices/find?status=#{status}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find a invoice by created_at" do
      created_at = @invoice1.created_at

      get "/api/v1/invoices/find?created_at=#{created_at}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find a invoice by updated_at" do
      updated_at = @invoice1.updated_at

      get "/api/v1/invoices/find?updated_at=#{updated_at}"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]
      expect(invoice["attributes"]["id"]).to eq(@invoice1.id)
    end
  end

  context "Find All" do
    it "can find all invoices by id" do
      id = @invoice1.id

      get "/api/v1/invoices/find_all?id=#{id}"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(1)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find all invoices by customer_id" do
      customer_id = @invoice1.customer_id

      get "/api/v1/invoices/find_all?customer_id=#{customer_id}"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(1)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find all invoices by merchant_id" do
      merchant_id = @invoice1.merchant_id

      get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find all invoices by status" do
      status = @invoice1.status

      get "/api/v1/invoices/find_all?status=#{status}"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find all invoices by created_at" do
      created_at = @invoice1.created_at

      get "/api/v1/invoices/find_all?created_at=#{created_at}"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can find all invoices by updated_at" do
      updated_at = @invoice1.updated_at

      get "/api/v1/invoices/find_all?updated_at=#{updated_at}"
      expect(response).to be_successful
      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to eq(@invoice1.id)
    end

    it "can send a random invoice" do
      get "/api/v1/invoices/random"
      expect(response).to be_successful

      rando = JSON.parse(response.body)
      expect(rando["data"].class).to eq(Hash)
      expect(rando["data"]["attributes"]).to be_present
      expect(rando.count).to eq(1)
    end
  end

  context "Relationships" do
    it "can get transactions for a specific invoice" do
      get "/api/v1/invoices/#{@invoice1.id}/transactions"
      expect(response).to be_successful

      transactions = JSON.parse(response.body)["data"]
      expect(transactions.count).to eq(1)
      expect(transactions.first["attributes"]["id"].to_s).to eq("#{@t1.id}")
    end

    it "can get items for a specific invoice" do
      get "/api/v1/invoices/#{@invoice1.id}/items"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]
      expect(items.count).to eq(2)
      expect(items.first["attributes"]["id"].to_s).to eq("#{@item1.id}")
    end

    it "can get invoice_items for a specific invoice" do
      get "/api/v1/invoices/#{@invoice1.id}/invoice_items"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["attributes"]["id"].to_s).to eq("#{@ii1.id}")
    end

    it "can get customer for a specific invoice" do
      get "/api/v1/invoices/#{@invoice1.id}/customer"
      expect(response).to be_successful

      customer = JSON.parse(response.body)
      expect(customer.count).to eq(1)
      expect(customer["data"]["attributes"]["id"].to_s).to eq("#{@cust48.id}")
    end

    it "can get merchant for a specific invoice" do
      get "/api/v1/invoices/#{@invoice1.id}/merchant"
      expect(response).to be_successful

      merchant = JSON.parse(response.body)
      expect(merchant.count).to eq(1)
      expect(merchant["data"]["attributes"]["id"].to_s).to eq("#{@merch1.id}")
    end
  end
end
