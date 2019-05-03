require "rails_helper"

RSpec.describe "Items API" do
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

  it "sends a list of items" do
    get "/api/v1/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  context "Find" do

  end

  context "Find All" do

  end

  context "Items Logic" do
    it "can send a requested quantity of top items by revenue" do
      get "/api/v1/items/most_revenue?quantity=#{2}"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]
      expect(items.count).to eq(2)
      expect(items.first["attributes"]["name"]).to eq("#{@item2.name}")
    end

    it "can send a requested quantity of top items by quantity" do
      get "/api/v1/items/most_items?quantity=#{2}"
      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]
      expect(items.count).to eq(2)
      expect(items.first["attributes"]["name"]).to eq("#{@item2.name}")
    end

    it "can send the date for the best day for a chosen item" do
      get "/api/v1/items/#{@item1.id}/best_day"
      expect(response).to be_successful

      day = JSON.parse(response.body)["data"]
      date = "2018-04-14".to_datetime
      expect(day["attributes"]["best_day"].to_date.day).to eq(13)
      expect(day["attributes"]["best_day"].to_date.month).to eq(4)
      expect(day["attributes"]["best_day"].to_date.year).to eq(2018)
    end
  end
end
