require 'rails_helper'

describe "Merchants API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    expect(merchant).to be_a(Hash)

    expect(merchant).to have_key("id")
    expect(merchant).to have_key("name")
    expect(merchant).to have_key("created_at")
    expect(merchant).to have_key("updated_at")

    expect(merchant["id"]).to be_a(Integer)
    expect(merchant["name"]).to be_a(String)
    expect(merchant["created_at"]).to be_a(String)
    expect(merchant["updated_at"]).to be_a(String)
  end
end
