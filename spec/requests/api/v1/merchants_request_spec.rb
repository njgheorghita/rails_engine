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

  it "finds and returns a single merchant by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant).to be_a(Hash)
    expect(merchant["id"]).to eq(Merchant.first.id)
    expect(merchant["name"]).to eq(Merchant.first.name)
  end

  it "finds and returns all merchants by id" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?id=#{merchants.first.id}"

    all_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_merchants).to be_a(Array)
    expect(all_merchants.count).to eq(1)

    all_merchants.each do |merchant|
      expect(merchant["id"]).to eq(merchants.first.id)
    end
  end

  it "finds and returns a random merchant" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)
    merchant_ids = Merchant.all.map { |merchant| merchant.id }

    expect(response).to be_success
    expect(merchant_ids).to include(merchant["id"])
  end

end
