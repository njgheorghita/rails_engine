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
    
    expect(customer).to have_key("id")
    expect(customer).to have_key("first_name")
    expect(customer).to have_key("last_name")
    expect(customer).to_not have_key("created_at")
    expect(customer).to_not have_key("updated_at")

    expect(customer["id"]).to be_a(Integer)
    expect(customer["first_name"]).to be_a(String)
    expect(customer["last_name"]).to be_a(String)
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

  it "finds and returns a single customer by first name" do
    create_list(:customer, 3)
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  
    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["first_name"]).to eq(customer.first_name)
  end

  it "finds and returns a single customer by last name" do
    create_list(:customer, 3)
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  
    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["last_name"]).to eq(customer.last_name)
  end

  it "finds and returns a single customer by created at" do
    create_list(:customer, 3)
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  
    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["first_name"]).to eq(customer.first_name)
  end

  it "finds and returns a single customer by updated at" do
    create_list(:customer, 3)
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")
  
    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["first_name"]).to eq(customer.first_name)
  end

  it "finds and returns all customers by id" do
    customers = create_list(:customer, 3)
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?id=#{customers.first.id}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(1)

    all_customers.each do |customer|
      expect(customer["id"]).to eq(customers.first.id)
    end
  end

  it "finds and returns all customers by first_name" do
    customers = create_list(:customer, 3)
    Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?first_name=#{customers.first.first_name}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(3)

    all_customers.each do |customer|
      expect(customer["first_name"]).to eq(customers.first.first_name)
    end
  end

  it "finds and returns all customers by last_name" do
    customers = create_list(:customer, 3)
    Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?last_name=#{customers.first.last_name}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(3)

    all_customers.each do |customer|
      expect(customer["last_name"]).to eq(customers.first.last_name)
    end
  end

  it "finds and returns all customers by created_at" do
    customers = create_list(:customer, 3)
    Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?created_at=#{customers.first.created_at}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(3)

    all_customers.each do |customer|
      expect(customer["last_name"]).to eq(customers.first.last_name)
    end
  end

  it "finds and returns all customers by updated_at" do
    customers = create_list(:customer, 3)
    Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?updated_at=#{customers.first.updated_at}"

    all_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(all_customers).to be_a(Array)
    expect(all_customers.count).to eq(3)

    all_customers.each do |customer|
      expect(customer["last_name"]).to eq(customers.first.last_name)
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

  it "searches case insensitively" do
    customer = Customer.create(first_name:"Georgy", last_name:"Porgy", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2013-03-25 09:54:09 UTC")

    get "/api/v1/customers/find?name=GEORGY"

    customer_return = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer_return).to be_a(Hash)
    expect(customer_return["first_name"]).to eq(customer.first_name)
  end

end
