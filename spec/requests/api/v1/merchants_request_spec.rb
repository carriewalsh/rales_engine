require "rails_helper"

describe "Merchants API" do
  before :each do
    @merch1 = Merchant.create(name: "Ondrea Chadburn", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @merch2 = Merchant.create(name: "Raff Faust", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @merch3 = Merchant.create(name: "Con Chilver", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")

    @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie")
    @cust49 = Customer.create(first_name: "Reynold", last_name: "Beed")
    @cust50 = Customer.create(first_name: "Christiano", last_name: "Trighton")

    @item1 = @merch1.items.create(name: "W.L. Weller Special Reserve",unit_price: 20000, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.")
    @item2 = @merch2.items.create(name: "W.L. Weller C.Y.P.B.",unit_price: 35000, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.")
    @item3 = @merch3.items.create(name: "Bulleit Bourbon",unit_price: 22000, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.")

    @invoice1 = @merch1.invoices.create(status: 'shipped')
    @invoice2 = @merch1.invoices.create(status: 'shipped')
    @invoice3 = @merch2.invoices.create(status: 'shipped')
    @invoice4 = @merch3.invoices.create(status: 'shipped')

    @cust48.invoices << @invoice1
    @cust49.invoices << @invoice2
    @cust48.invoices << @invoice3
    @cust50.invoices << @invoice4

    @ii1 = @item1.invoice_items.create(quantity: 30, unit_price: 20000, created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
    @ii2 = @item2.invoice_items.create(quantity: 20, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii3 = @item3.invoice_items.create(quantity: 30, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")
    @ii4 = @item2.invoice_items.create(quantity: 20, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
    @ii5 = @item3.invoice_items.create(quantity: 10, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")

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

  it "sends a list of merchants" do
    get "/api/v1/merchants"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it "can get a single merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  context "Find" do
    it "can find a merchant by name" do
      name = @merch1.name

      get "/api/v1/merchants/find?name=#{name}"
      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["attributes"]["name"]).to eq(name)
    end

    it "can find merchant by created_at" do
      created_at = @merch1.created_at


      get "/api/v1/merchants/find?created_at=#{created_at}"
      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["attributes"]["id"]).to eq(@merch1.id)
    end

    it "can find merchant by updated_at" do
      updated_at = @merch1.updated_at


      get "/api/v1/merchants/find?updated_at=#{updated_at}"
      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]
      expect(merchant["attributes"]["id"]).to eq(@merch1.id)
    end
  end

  context "Relationships" do
    xit "can get all items for a specific merchant" do
      get "/api/v1/merchants/#{@merch2.id}/items"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]
      expect(items.count).to eq(1)
    end

    xit "can get all invoices for a specific merchant" do
      get "/api/v1/merchants/#{@merch1.id}/invoices"
      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(2)

      get "/api/v1/merchants/#{@merch2.id}/invoices"

      invoices = JSON.parse(response.body)["data"]
      expect(invoices.count).to eq(0)
    end
  end

  describe "Merchants Logic" do
    it "can send a list of a requested quantity of top merchants by revenue" do
      get '/api/v1/merchants/most_revenue?quantity=1'
      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]
      expect(merchants.count).to eq(1)

      get '/api/v1/merchants/most_revenue?quantity=3'
      merchants = JSON.parse(response.body)["data"]

      expect(merchants.count).to eq(2)
    end

    it "can send a list of a requested quantity of top merchants by quantity" do
      get '/api/v1/merchants/most_items?quantity=1'
      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]
      expect(merchants.count).to eq(1)

      get '/api/v1/merchants/most_items?quantity=3'
      merchants = JSON.parse(response.body)["data"]

      expect(merchants.count).to eq(2)
    end

    it "can send a total revenue amount for all merchants on a chosen date" do
      date = "2012-04-17"
      get "/api/v1/merchants/revenue?date=#{date}"
      expect(response).to be_successful
      merchants = JSON.parse(response.body)["data"]
      expect(merchants["attributes"]["total_revenue"]).to eq("0.0")
    end

    it "can send a favorite customer for a merchant" do
      get "/api/v1/merchants/#{@merch1.id}/favorite_customer"
      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expect(customer["attributes"]["first_name"]).to eq("Trixie")
    end

    it "can send the total revenue for a specific merchant" do
      get "/api/v1/merchants/#{@merch1.id}/revenue"
    end

    it "can send the date_revenue for a specific merchant" do
      date = "2012-04-17"
      get "/api/v1/merchants/#{@merch1.id}/revenue?date=#{date}"
    end

    it "can send a list of pending customers" do
      get "/api/v1/merchants/#{@merch1.id}/customers_with_pending_invoices"
      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]
    end
  end
end
