require 'rails_helper'

describe "Invoices API" do
  it "returns a list of invoices in JSON" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    invoices = JSON.parse(response.body)
    invoice = invoices.first

    expect(response).to be_success

    expect(invoices.count).to eq(3)
    expect(invoice).to be_a(Hash)

    expect(invoice["id"]).to be_a(Integer)
  end

  it "returns a single invoice by id in JSON" do
    create_list(:invoice, 3)
    test_invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{test_invoice.id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to       be_success
    expect(invoice["id"]).to  eq(test_invoice.id)
  end

  it "finds and returns a single invoice by id" do
    create_list(:invoice, 3)
    test_invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/find?id=#{test_invoice.id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to       be_success
    expect(invoice["id"]).to  eq(test_invoice.id)
  end

  it "finds and returns all invoice by id" do
    test_invoice = create_list(:invoice, 3)

    get "/api/v1/invoices/find_all?id=#{test_invoice.first.id}"

    all_invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_invoices).to be_a(Array)
    expect(all_invoices.count).to eq(1)

    all_invoices.each do |invoice|
      expect(invoice["id"]).to eq(test_invoice.first.id)
    end
  end

  it "finds and returns a random invoice" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)
    invoice_ids = Invoice.all.map { |invoice| invoice.id }

    expect(response).to be_success
    expect(invoice_ids).to include(invoice["id"])
  end

  it "returns a collection of associated transactions" do
    invoice = Invoice.create(customer_id:22, merchant_id:32, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_1 = Transaction.create(invoice_id: invoice.id, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_2 = Transaction.create(invoice_id: invoice.id, credit_card_number:"1111111111111111", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction_3 = Transaction.create(invoice_id: 77, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{invoice.id}/transactions.json"

    transactions_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions_return).to be_a(Array)
    expect(transactions_return.length).to eq(2)
    expect(transactions_return.first["id"]).to eq(transaction_1.id)
    expect(transactions_return.second["id"]).to eq(transaction_2.id)
  end

  it "returns a collection of associated invoice items" do
    invoice = Invoice.create(customer_id:22, merchant_id:32, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_1 = InvoiceItem.create(item_id: 11, invoice_id: invoice.id, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_2 = InvoiceItem.create(item_id: 7, invoice_id: invoice.id, quantity: 2, unit_price:123, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item_3 = InvoiceItem.create(item_id: 3, invoice_id: 5, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{invoice.id}/invoice_items.json"

    invoice_items_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items_return).to be_a(Array)
    expect(invoice_items_return.length).to eq(2)
    expect(invoice_items_return.first["id"]).to eq(invoice_item_1.id)
    expect(invoice_items_return.second["id"]).to eq(invoice_item_2.id)
  end

  it "returns a collection of associated items" do
    invoice = Invoice.create(customer_id:22, merchant_id:32, status:"shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item_1 = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item_2 = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    item_3 = Item.create(name: "awesome", description: "thing", unit_price:22, merchant_id:32, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice_item = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice.id, quantity: 9, unit_price:533, created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{invoice.id}/items.json"

    items_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(items_return).to be_a(Array)
    expect(items_return.length).to eq(1)
    expect(items_return.first["id"]).to eq(item_1.id)
  end

  it "returns the customer associated with a single invoice" do
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    invoice = Invoice.create(customer_id: customer.id, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{invoice.id}/customer.json"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["id"]).to eq(customer.id)
    expect(customer_return["first_name"]).to eq(customer.first_name)
    expect(customer_return["last_name"]).to eq(customer.last_name)
  end

  it "returns the associated merchant" do
    merchant = Merchant.create(name:"George", created_at: "2011-03-25 09:54:09 UTC", updated_at: "2014-03-25 09:54:09 UTC")
    invoice = Invoice.create(customer_id: 5, merchant_id: merchant.id, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/invoices/#{invoice.id}/merchant.json"

    merchant_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_return).to be_a(Hash)
    expect(merchant_return["name"]).to eq(merchant.name)
  end

end
