require "rails_helper"

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 4)

    get "/api/v1/merchants"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(4)
  end

  xit "can get one merchant by id" do

  end

  xit "can get one merchant by name" do

  end
end
