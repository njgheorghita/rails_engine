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

end
