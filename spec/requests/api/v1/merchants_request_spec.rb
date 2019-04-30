require "rails_helper"

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 4)

    get "/api/v1/merchants"

    expect(response).to be_successful
  end

  xit "can get one merchant by id" do

  end

  xit "can get one merchant by name" do

  end
end
