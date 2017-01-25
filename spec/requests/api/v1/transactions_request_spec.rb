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
    expect(transaction).to have_key("invoice_id")
    expect(transaction).to have_key("credit_card_number")
    expect(transaction).to have_key("result")
    expect(transaction).to_not have_key("created_at")
    expect(transaction).to_not have_key("updated_at")

    expect(transaction["id"]).to be_a(Integer)
  end

  it "returns a single transaction by id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "finds and returns a single transaction by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    transaction_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(Transaction.first.id)
  end

  it "finds and returns a single transaction by credit_card_number" do
    create_list(:transaction, 3)
    transaction = Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    transaction_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(transaction.id)
  end

  it "finds and returns a single transaction by result" do
    create_list(:transaction, 3)
    transaction = Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find?result=#{transaction.result}"

    transaction_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(transaction.id)
  end

  it "finds and returns a single transaction by created_at" do
    create_list(:transaction, 3)
    transaction = Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    transaction_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(transaction.id)
  end

  it "finds and returns a single transaction by updated_at" do
    create_list(:transaction, 3)
    transaction = Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    transaction_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(transaction.id)
  end


  it "finds and returns all transactions by id" do
    transactions = create_list(:transaction, 3)

    get "/api/v1/transactions/find_all?id=#{transactions.first.id}"

    all_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_transactions).to be_a(Array)
    expect(all_transactions.count).to eq(1)
  end

  it "finds and returns all transactions by credit_card_number" do
    transactions = create_list(:transaction, 3)
    Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find_all?credit_card_number=#{transactions.first.credit_card_number}"

    all_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_transactions).to be_a(Array)
    expect(all_transactions.count).to eq(3)
  end

  it "finds and returns all transactions by result" do
    transactions = create_list(:transaction, 3)
    Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find_all?result=#{transactions.first.result}"

    all_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_transactions).to be_a(Array)
    expect(all_transactions.count).to eq(3)
  end

  it "finds and returns all transactions by created_at" do
    transactions = create_list(:transaction, 3)
    Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find_all?created_at=#{transactions.first.created_at}"

    all_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_transactions).to be_a(Array)
    expect(all_transactions.count).to eq(3)
  end

  it "finds and returns all transactions by updated_at" do
    transactions = create_list(:transaction, 3)
    Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/find_all?updated_at=#{transactions.first.updated_at}"

    all_transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_transactions).to be_a(Array)
    expect(all_transactions.count).to eq(3)
  end

  it "finds and returns a random transaction" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)
    transactions_ids = Transaction.all.map { |transaction| transaction.id }

    expect(response).to be_success
    expect(transactions_ids).to include(transaction["id"])
  end

  it "searches transactions case insensitively" do
    transaction = Transaction.create(invoice_id: 3, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  
    get "/api/v1/merchants/find?result=SUCCESS"
  
    transaction_return = JSON.parse(response.body)
  
    expect(response).to be_success
    expect(transaction_return).to be_a(Hash)
    expect(transaction_return["id"]).to eq(transaction.id)
  end

  it "returns the invoice associated with a single transaction" do
    invoice = Invoice.create(customer_id:22, merchant_id:32, status:"hello", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
    transaction = Transaction.create(invoice_id: invoice.id, credit_card_number:"9999999999999999", credit_card_expiration_date: "", result: "success", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice_response = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_response).to be_a(Hash)
    expect(invoice_response["id"]).to eq(invoice.id)
    expect(invoice_response["customer_id"]).to eq(invoice.customer_id)
    expect(invoice_response["merchant_id"]).to eq(invoice.merchant_id)
    expect(invoice_response["status"]).to eq(invoice.status)
  end

end
