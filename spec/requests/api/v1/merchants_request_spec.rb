require "rails_helper"

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 4)

    get "/api/v1/merchants"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(4)
  end

  it "can get one merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  xit "can get one merchant by name" do
    name = create(:merchant).name.split.join("-")

    get "/api/v1/merchants/#{name}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["name"]).to eq(name)
  end
end
