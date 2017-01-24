require 'rails_helper'

describe "Items API" do
  it "returns a list of items in JSON" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    items = JSON.parse(response.body)
    item = items.first

    expect(response).to be_success

    expect(items.count).to eq(3)
    expect(item).to be_a(Hash)

    expect(item["id"]).to be_a(Integer)
  end

  it "returns a single item by id in JSON" do
    create_list(:item, 3)
    test_item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/items/#{test_item.id}.json"

    item = JSON.parse(response.body)

    expect(response).to       be_success
    expect(item["id"]).to  eq(test_item.id)
  end

  xit "finds and returns a single invoice by id" do
    create_list(:invoice, 3)
    test_item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/find?id=#{test_invoice.id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to       be_success
    expect(invoice["id"]).to  eq(test_invoice.id)
  end

end
