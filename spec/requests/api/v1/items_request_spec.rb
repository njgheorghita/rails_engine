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
    expect(item["id"]).to     eq(test_item.id)
  end

  it "finds and returns a single item by id" do
    create_list(:item, 3)
    test_item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/items/find?id=#{test_item.id}.json"

    item = JSON.parse(response.body)

    expect(response).to       be_success
    expect(item["id"]).to  eq(test_item.id)
  end

  it "finds and returns all items by id" do
    items = create_list(:item, 3)

    get "/api/v1/items/find_all?id=#{items.first.id}"

    all_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_items).to be_a(Array)
    expect(all_items.count).to eq(1)

    all_items.each do |item|
      expect(item["id"]).to eq(items.first.id)
    end
  end

  it "finds and returns a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)
    item_ids = Item.all.map { |item| item.id }

    expect(response).to be_success
    expect(item_ids).to include(item["id"])
  end

  it "returns a collection of associated invoice items" do
    item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_1 = InvoiceItem.create(item_id: 11, invoice_id: 78, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_2 = InvoiceItem.create(item_id: item.id, invoice_id: 5, quantity: 2, unit_price:123, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_3 = InvoiceItem.create(item_id: item.id, invoice_id: 54, quantity: 3, unit_price:100, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/items/#{item.id}/invoice_items.json"

    invoice_items_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items_return).to be_a(Array)
    expect(invoice_items_return.length).to eq(2)
    expect(invoice_items_return.first["id"]).to eq(invoice_item_2.id)
    expect(invoice_items_return.second["id"]).to eq(invoice_item_3.id)
  end

  it "returns the merchant associated with a single item" do
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")
    invoice = Invoice.create(customer_id: 5, merchant_id: merchant.id, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id: merchant.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/items/#{item.id}/merchant.json"

    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

end
