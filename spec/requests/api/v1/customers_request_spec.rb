require 'rails_helper'

describe "Customers API" do
  it "returns a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    customers = JSON.parse(response.body)
    customer = customers.first

    expect(response).to be_success

    expect(customers.count).to eq(3)
    expect(customer).to be_a(Hash)

    expect(customer["id"]).to be_a(Integer)
  end

  it "returns a single customer by id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  it "finds and returns a single customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer).to be_a(Hash)
    expect(customer["id"]).to eq(Customer.first.id)
  end

end
