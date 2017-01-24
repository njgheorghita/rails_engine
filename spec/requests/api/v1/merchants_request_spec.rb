require 'rails_helper'

describe "Merchants API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(response).to be_success
    expect(merchants.count).to eq(3)
    expect(merchant).to be_a(Hash)

    expect(merchant).to have_key("id")
    expect(merchant).to have_key("name")
    expect(merchant).to_not have_key("created_at")
    expect(merchant).to_not have_key("updated_at")

    expect(merchant["id"]).to be_a(Integer)
    expect(merchant["name"]).to be_a(String)
  end

  it "returns a single merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

end
