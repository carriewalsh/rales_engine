require "rails_helper"

RSpec.describe "Transactions API" do
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

    @t1 = @invoice1.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @t2 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
    @t3 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success", created_at: "2012-03-24T14:14:14.000Z",updated_at: "2012-03-24T14:14:14.000Z")
  end

  it "sends a list of transactions" do
    get "/api/v1/transactions"
    expect(response).to be_successful
    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end

  it "sends a single transaction by id" do
    get "/api/v1/transactions/#{@t1.id}"
    expect(response).to be_successful
    transactions = JSON.parse(response.body)

    expect(transactions["data"]["attributes"]["result"]).to eq('success')
  end

  context "Find" do
    it "can find transaction by id" do
      id = @t1.id

      get "/api/v1/transactions/find?id=#{id}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["id"].to_i).to eq(id)
    end

    it "can find transaction by invoice_id" do
      invoice_id = @t1.invoice_id

      get "/api/v1/transactions/find?invoice_id=#{invoice_id}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["invoice_id"].to_i).to eq(invoice_id)
    end

    it "can find transaction by credit_card_number" do
      credit_card_number = @t1.credit_card_number

      get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["credit_card_number"]).to eq(credit_card_number)
    end

    it "can find transaction by result" do
      result = @t1.result

      get "/api/v1/transactions/find?result=#{result}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["result"]).to eq(result)
    end

    it "can find transaction by created_at" do
      created_at = @t1.created_at

      get "/api/v1/transactions/find?created_at=#{created_at}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]
      expect(transaction["attributes"]["id"]).to eq(@t1.id)
    end

    it "can find transaction by updated_at" do
      updated_at = @t1.updated_at

      get "/api/v1/transactions/find?updated_at=#{updated_at}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]
      expect(transaction["attributes"]["id"]).to eq(@t1.id)
    end
  end

  context "Find All" do
    it "can find all transactions by id" do
      id = @t1.id

      get "/api/v1/transactions/find?id=#{id}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["id"].to_i).to eq(id)
    end

    it "can find all transactions by invoice_id" do
      invoice_id = @t1.invoice_id

      get "/api/v1/transactions/find?invoice_id=#{invoice_id}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["invoice_id"].to_i).to eq(invoice_id)
    end

    it "can find all transactions by credit_card_number" do
      credit_card_number = @t1.credit_card_number

      get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["credit_card_number"]).to eq(credit_card_number)
    end

    it "can find all transactions by result" do
      result = @t1.result

      get "/api/v1/transactions/find?result=#{result}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]

      expect(transaction["attributes"]["result"]).to eq(result)
    end

    it "can find all transactions by created_at" do
      created_at = @t1.created_at

      get "/api/v1/transactions/find?created_at=#{created_at}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]
      expect(transaction["attributes"]["id"]).to eq(@t1.id)
    end

    it "can find all transactions by updated_at" do
      updated_at = @t1.updated_at

      get "/api/v1/transactions/find?updated_at=#{updated_at}"
      expect(response).to be_successful

      transaction = JSON.parse(response.body)["data"]
      expect(transaction["attributes"]["id"]).to eq(@t1.id)
    end
  end

  context "Relationships" do
    it "can get invoice for a specific transaction" do
      get "/api/v1/transactions/#{@t1.id}/invoice"
      expect(response).to be_successful

      invoice = JSON.parse(response.body)
      expect(invoice.count).to eq(1)
    end
  end
end
