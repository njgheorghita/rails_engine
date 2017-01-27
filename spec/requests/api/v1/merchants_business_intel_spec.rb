require 'rails_helper'

describe 'Merchants Business Intelligence API' do
  before(:each) do
    @merchant_1 = Merchant.create(name:'first', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @merchant_2 = Merchant.create(name:'second', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @merchant_3 = Merchant.create(name:'third', created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    @customer_1 = Customer.create(first_name: "Freddie", last_name: "Mercury", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @customer_2 = Customer.create(first_name: "Brian", last_name: "May", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    invoice_1 = Invoice.create(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_2 = Invoice.create(customer_id: @customer_2.id, merchant_id: @merchant_2.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_3 = Invoice.create(customer_id: @customer_1.id, merchant_id: @merchant_3.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    item_1 = Item.create(name: "awesome", description: "thing", unit_price:1250, merchant_id: @merchant_1.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item_2 = Item.create(name: "cooling", description: "swing", unit_price:5000, merchant_id: @merchant_2.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    @specitem_3 = Item.create(name: "raptors", description: "shirt", unit_price:8000, merchant_id: @merchant_3.id, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price:1250, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    InvoiceItem.create(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 6, unit_price:5000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    InvoiceItem.create(item_id: @specitem_3.id, invoice_id: invoice_3.id, quantity: 9, unit_price:8000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    transaction_1 = Transaction.create(invoice_id: invoice_1.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_2 = Transaction.create(invoice_id: invoice_2.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_3 = Transaction.create(invoice_id: invoice_3.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-04-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  end

  it 'returns the top "x" merchants ranked by total revenue' do
    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    top_merchants_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_merchants_return).to be_a(Array)

    expect(top_merchants_return.first["id"]).to   eq(@merchant_3.id)
    expect(top_merchants_return.second["id"]).to  eq(@merchant_2.id)
  end

  it 'returns the total revenue for that merchant across all transactions' do
    current_merchant_id = @merchant_1.id

    get "/api/v1/merchants/#{current_merchant_id}/revenue"

    merchant_revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_revenue).to be_a(Hash)
    expect(merchant_revenue["revenue"]).to eq("37.50")
  end

  it 'returns the top "x" merchants ranked by total number of items sold' do
    quantity = 2

    get "/api/v1/merchants/most_items?quantity=#{quantity}"

    top_merchants_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_merchants_return).to be_a(Array)
    expect(top_merchants_return.first["id"]).to eq(@merchant_3.id)
    expect(top_merchants_return.second["id"]).to eq(@merchant_2.id)
  end

  it 'returns the total revenue for date "x" for one merchant' do
    date = "2012-03-25 09:54:09"
    merchant_id = @merchant_1.id

    get "/api/v1/merchants/#{merchant_id}/revenue?date=#{date}"

    total_revenue_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(total_revenue_return).to be_a(Hash)
    expect(total_revenue_return["revenue"]).to eq("37.50")
  end

  it 'returns the total revenue for all merchants for a day' do
    date = "2012-03-25 09:54:09"

    get "/api/v1/merchants/revenue?date=#{date}"

    revenue_returned = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue_returned).to be_a(Hash)
    expect(revenue_returned["total_revenue"]).to eq("1057.50")
  end

  it 'returns a merchants favorite customer' do
    invoice_3       = Invoice.create(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    InvoiceItem.create(item_id: @specitem_3.id, invoice_id: invoice_3.id, quantity: 9, unit_price:8000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_3   = Transaction.create(invoice_id: invoice_3.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-04-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    invoice_4       = Invoice.create(customer_id: @customer_2.id, merchant_id: @merchant_1.id, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    InvoiceItem.create(item_id: @specitem_3.id, invoice_id: invoice_4.id, quantity: 9, unit_price:8000, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_3   = Transaction.create(invoice_id: invoice_4.id, credit_card_number:"999", credit_card_expiration_date: "", result: "success", created_at: "2012-04-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    current_merchant_id = @merchant_1.id

    get "/api/v1/merchants/#{current_merchant_id}/favorite_customer"

    customer_returned = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_returned).to be_a(Hash)
    
    expect(customer_returned["id"]).to eq(@customer_1.id)
  end
end
