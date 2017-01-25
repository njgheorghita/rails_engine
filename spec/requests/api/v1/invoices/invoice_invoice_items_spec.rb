require 'rails_helper'

describe "Invoice invoice items API" do
  it "returns a collection of associated invoice items" do
    invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    create_list(:invoice_items, 3)

    get "/api/v1/invoices/#{invoice.id}/transactions.json"

    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(response).to be_success

    expect(transactions.count).to eq(3)
    expect(transaction).to be_a(Hash)

    expect(transaction).to have_key("id")
    expect(transaction).to_not have_key("invoice_id")
    expect(transaction).to_not have_key("credit_card_number")
    expect(transaction).to_not have_key("result")
    expect(transaction).to_not have_key("created_at")
    expect(transaction).to_not have_key("updated_at")

    expect(transaction["id"]).to be_a(Integer)
  end

end
