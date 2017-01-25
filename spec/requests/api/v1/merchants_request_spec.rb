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
  end

  it "finds and returns a single merchant by name" do
    create_list(:merchant, 3)
    merchant = Merchant.create(name:"George", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

  it "finds and returns a single merchant by created_at" do
    create_list(:merchant, 3)
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

  it "finds and returns a single merchant by updated_at" do
    create_list(:merchant, 3)
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

  it "finds and returns all merchants by id" do
    merchants = create_list(:merchant, 3)
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find_all?id=#{merchants.first.id}"

    all_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_merchants).to be_a(Array)
    expect(all_merchants.count).to eq(1)

    all_merchants.each do |merchant|
      expect(merchant["id"]).to eq(merchants.first.id)
    end
  end

  it "finds and returns all merchants by name" do
    merchants = create_list(:merchant, 3)
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find_all?name=#{merchants.first.name}"

    all_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_merchants).to be_a(Array)
    expect(all_merchants.count).to eq(3)

    all_merchants.each do |merchant|
      expect(merchant["name"]).to eq(merchants.first.name)
    end
  end

  it "finds and returns all merchants by created_at" do
    merchants = create_list(:merchant, 3)
    Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find_all?created_at=#{merchants.first.created_at}"

    all_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_merchants).to be_a(Array)
    expect(all_merchants.count).to eq(3)

    all_merchants.each do |merchant|
      expect(merchant["name"]).to eq(merchants.first.name)
    end
  end

  it "finds and returns all merchants by updated_at" do
    merchants = create_list(:merchant, 3)
    Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find_all?updated_at=#{merchants.first.updated_at}"

    all_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_merchants).to be_a(Array)
    expect(all_merchants.count).to eq(3)

    all_merchants.each do |merchant|
      expect(merchant["name"]).to eq(merchants.first.name)
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

  it "searches case insensitively" do
    merchant = Merchant.create(name:"GEORGE", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/merchants/find?name=george"

    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

  it "returns all items associated with a single merchant" do
    merchant = Merchant.create(name:"GEORGE", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    first_item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:merchant.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    second_item = Item.create(name: "more", description: "stuff", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    third_item = Item.create(name: "crazy", description: "cool", unit_price:22, merchant_id:merchant.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/merchants/#{merchant.id}/items"

    items_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_return).to be_a(Array)
    expect(items_return.length).to eq(2)
    expect(items_return.first["name"]).to eq(first_item.name)
    expect(items_return.second["name"]).to eq(third_item.name)
  end

  it "returns all invoices associated with merchant from their known orders" do
    merchant = Merchant.create(name:"GEORGE", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    first_invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    second_invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    test_invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")


  end
end
