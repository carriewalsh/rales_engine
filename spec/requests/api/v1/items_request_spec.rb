require "rails_helper"

RSpec.describe "Items API" do
  before :each do
    @merch1 = Merchant.create(name: "Ondrea Chadburn")
    @merch2 = Merchant.create(name: "Raff Faust")
    @merch3 = Merchant.create(name: "Con Chilver")
    @item1 = @merch1.items.create(name: "W.L. Weller Special Reserve",unit_price: 20000, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.")
    @item2 = @merch2.items.create(name: "W.L. Weller C.Y.P.B.",unit_price: 35000, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.")
    @item3 = @merch3.items.create(name: "Bulleit Bourbon",unit_price: 22000, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.")
  end

  it "sends a list of items" do
    get "/api/v1/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end
end
