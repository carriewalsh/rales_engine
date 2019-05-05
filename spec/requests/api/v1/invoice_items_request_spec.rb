require "rails_helper"

RSpec.describe "InvoiceItems API" do
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

    @invoice1 = @merch1.invoices.create(status: 'shipped')
    @invoice2 = @merch1.invoices.create(status: 'shipped')

    @cust48.invoices << @invoice1
    @cust49.invoices << @invoice2

    @ii1 = @item1.invoice_items.create(quantity: 10, unit_price: 20000, created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @ii2 = @item2.invoice_items.create(quantity: 10, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii3 = @item3.invoice_items.create(quantity: 10, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")

    @invoice1.invoice_items << @ii1
    @invoice1.invoice_items << @ii2
    @invoice2.invoice_items << @ii3
  end

  it "sends a list of invoice_items" do
    get "/api/v1/invoice_items"
    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end

  context "Find" do
    it "can find an invoice_item by id" do
      id = @ii1.id

      get "/api/v1/invoice_items/find?id=#{id}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by item_id" do
      item_id = @ii1.item_id

      get "/api/v1/invoice_items/find?item_id=#{item_id}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by invoice_id" do
      invoice_id = @ii1.invoice_id

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by quantity" do
      quantity = @ii1.quantity

      get "/api/v1/invoice_items/find?quantity=#{quantity}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by unit_price" do
      unit_price = @ii1.unit_price

      get "/api/v1/invoice_items/find?unit_price=#{unit_price}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by created_at" do
      created_at = @ii1.created_at

      get "/api/v1/invoice_items/find?created_at=#{created_at}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find an invoice_item by updated_at" do
      updated_at = @ii1.updated_at

      get "/api/v1/invoice_items/find?updated_at=#{updated_at}"
      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)["data"]
      expect(invoice_item["attributes"]["id"]).to eq(@ii1.id)
    end
  end

  context "Find All" do
    it "can find all invoice_items by id" do
      id = @ii1.id

      get "/api/v1/invoice_items/find_all?id=#{id}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by item_id" do
      item_id = @ii1.item_id

      get "/api/v1/invoice_items/find_all?item_id=#{item_id}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by invoice_id" do
      invoice_id = @ii1.invoice_id

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_id}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by quantity" do
      quantity = @ii1.quantity

      get "/api/v1/invoice_items/find_all?quantity=#{quantity}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(3)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by unit_price" do
      unit_price = @ii1.unit_price

      get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by created_at" do
      created_at = @ii1.created_at

      get "/api/v1/invoice_items/find_all?created_at=#{created_at}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find all invoice_items by updated_at" do
      updated_at = @ii1.updated_at

      get "/api/v1/invoice_items/find_all?updated_at=#{updated_at}"
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["attributes"]["id"]).to eq(@ii1.id)
    end

    it "can find a random invoice_item" do
      get "/api/v1/invoice_items/random"
      expect(response).to be_successful

      rando = JSON.parse(response.body)
      expect(rando["data"].class).to eq(Hash)
      expect(rando["data"]["attributes"]).to be_present
      expect(rando.count).to eq(1)
    end
  end

  context "Relationships" do
    it "can get invoice for a specific invoice_item" do
      get "/api/v1/invoice_items/#{@ii1.id}/invoice"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)
      expect(invoice.count).to eq(1)

      expect(invoice["data"]["attributes"]["id"].to_s).to eq("#{@invoice1.id}")
    end

    it "can get item for a specific invoice_item" do
      get "/api/v1/invoice_items/#{@ii1.id}/item"
      expect(response).to be_successful

      item = JSON.parse(response.body)
      expect(item.count).to eq(1)
      expect(item["data"]["attributes"]["id"].to_s).to eq("#{@item1.id}")
    end
  end
end
