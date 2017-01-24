require 'rails_helper'

describe "Transactions API" do
  it "returns a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions.json'

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
    # expect(transaction["credit_card_number"]).to be_a(String)
    # expect(transaction["result"]).to be_a(String)
  end

  it "returns a single transaction by id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end
end
