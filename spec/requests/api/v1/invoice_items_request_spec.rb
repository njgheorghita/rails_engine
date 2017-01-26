require 'rails_helper'

describe "Invoice Items API" do
  it "returns a list of invoice items in JSON" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    invoice_items = JSON.parse(response.body)
    invoice_item = invoice_items.first

    expect(response).to be_success

    expect(invoice_items.count).to eq(3)
    expect(invoice_item).to be_a(Hash)

    expect(invoice_item["id"]).to be_a(Integer)
  end

  it "returns a single invoice_item by id in JSON" do
    create_list(:invoice_item, 3)
    test_invoice_item = InvoiceItem.create(item_id: 3, invoice_id: 5, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoice_items/#{test_invoice_item.id}.json"

    invoice_item = JSON.parse(response.body)

    expect(response).to       be_success
    expect(invoice_item["id"]).to  eq(test_invoice_item.id)
  end

  it "finds and returns a single invoice_item by id" do
    create_list(:invoice_item, 3)
    test_invoice_item = InvoiceItem.create(item_id: 3, invoice_id: 5, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoice_items/find?id=#{test_invoice_item.id}.json"

    invoice_item = JSON.parse(response.body)

    expect(response).to       be_success
    expect(invoice_item["id"]).to  eq(test_invoice_item.id)
  end

  it "finds and returns all invoice_items by id" do
    invoice_items = create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/find_all?id=#{invoice_items.first.id}"

    all_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_invoice_items).to be_a(Array)
    expect(all_invoice_items.count).to eq(1)

    all_invoice_items.each do |invoice_item|
      expect(invoice_item["id"]).to eq(invoice_items.first.id)
    end
  end

  it "finds and returns a random invoice_item" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)
    invoice_item_ids = InvoiceItem.all.map { |invoice_item| invoice_item.id }

    expect(response).to be_success
    expect(invoice_item_ids).to include(invoice_item["id"])
  end

  it "returns the invoice associated with a single invoice item" do
    invoice = Invoice.create(customer_id: 5, merchant_id: 15, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id: 15, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice.json"

    invoice_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_return).to be_a(Hash)
    expect(invoice_return["id"]).to eq(invoice.id)
  end

  it "returns the item associated with a single invoice item" do
    invoice = Invoice.create(customer_id: 5, merchant_id: 15, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id: 15, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoice_items/#{invoice_item.id}/item.json"

    item_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(item_return).to be_a(Hash)
    expect(item_return["id"]).to eq(item.id)
  end

end
