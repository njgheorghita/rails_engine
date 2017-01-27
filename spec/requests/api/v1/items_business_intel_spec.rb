require 'rails_helper'

describe 'Items Business Intelligence API' do
  before(:each) do
    @merchant_1 = Merchant.create(name:'first', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @merchant_2 = Merchant.create(name:'second', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @merchant_3 = Merchant.create(name:'third', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    invoice_1 = Invoice.create(customer_id:1, merchant_id: @merchant_1.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_2 = Invoice.create(customer_id:2, merchant_id: @merchant_2.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_3 = Invoice.create(customer_id:3, merchant_id: @merchant_3.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    @item_1 = Item.create(name: "awesome", description: "thing", unit_price:1250, merchant_id: @merchant_1.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @item_2 = Item.create(name: "cooling", description: "swing", unit_price:5000, merchant_id: @merchant_2.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @item_3 = Item.create(name: "raptors", description: "shirt", unit_price:8000, merchant_id: @merchant_3.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price:1250, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_2 = InvoiceItem.create(item_id: @item_2.id, invoice_id: invoice_2.id, quantity: 6, unit_price:5000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_3 = InvoiceItem.create(item_id: @item_3.id, invoice_id: invoice_3.id, quantity: 9, unit_price:8000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    transaction_1 = Transaction.create(invoice_id: invoice_1.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_2 = Transaction.create(invoice_id: invoice_2.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_3 = Transaction.create(invoice_id: invoice_3.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-04-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  end

  it 'returns the top "x" items ranked by total revenue generated' do
    quantity = 2

    get "/api/v1/items/most_revenue?quantity=#{quantity}"

    items_returned = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_returned).to be_a(Array)
    expect(items_returned.first["name"]).to eq("raptors")
    expect(items_returned.second["name"]).to eq("cooling")
  end

  it 'returns the top "x" items ranked by total number of items sold' do
    quantity = 2

    get "/api/v1/items/most_items?quantity=#{quantity}"

    top_items_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_items_return).to be_a(Array)
    expect(top_items_return.first["id"]).to eq(@item_3.id)
    expect(top_items_return.second["id"]).to eq(@item_2.id)
  end

  xit 'returns the date with the most sales for the given item using the invoice date' do

    get "/api/v1/items/#{@item_1.id}/best_day"

    top_sales_date_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(date).to be_instance_of(Hash)
  end

end
