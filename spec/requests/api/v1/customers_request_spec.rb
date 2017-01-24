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

  it "finds and returns all customers by id" do
    customers = create_list(:customer, 3)

    get "/api/v1/customers/find_all?id=#{customers.first.id}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(1)

    all_customers.each do |customer|
      expect(customer["id"]).to eq(customers.first.id)
    end
  end

  it "finds and returns a random customer" do
    create_list(:customer, 3)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)
    customers_ids = Customer.all.map { |customer| customer.id }

    expect(response).to be_success
    expect(customers_ids).to include(customer["id"])
  end

end
