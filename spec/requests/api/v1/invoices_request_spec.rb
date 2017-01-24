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

  xit "returns a single invoice by id" do
    create(:invoice)

    get "/api/v1/invoices/#{id}.json"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

end
