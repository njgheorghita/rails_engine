# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'CSV'

customers_text = File.read(Rails.root.join('lib', 'seeds', 'customers.csv'))
customers_csv = CSV.parse(customers_text, :headers => true)
customers_csv.each do |row|
  Customer.create(
    first_name:   row['first_name'], 
    last_name:    row['last_name'], 
    created_at:   row['created_at'],
    updated_at:   row['updated_at']
  )
end 

invoice_items_text = File.read(Rails.root.join('lib', 'seeds', 'invoice_items.csv'))
invoice_items_csv = CSV.parse(invoice_items_text, :headers => true)
invoice_items_csv.each do |row|
  InvoiceItem.create( 
    item_id:      row['item_id'],
    invoice_id:   row["invoice_id"],
    quantity:     row["quantity"],
    unit_price:   row["unit_price"],
    created_at:   row["created_at"],
    updated_at:   row["updated_at"]
  )
end

invoices_text = File.read(Rails.root.join('lib', 'seeds', 'invoices.csv'))
invoices_csv = CSV.parse(invoices_text, :headers => true)
invoices_csv.each do |row|
  Invoice.create(     
    customer_id:  row["customer_id"],
    merchant_id:  row["merchant_id"],
    status:       row["status"],
    created_at:   row["created_at"],
    updated_at:   row["updated_at"]
  )
end

items_text = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
items_csv = CSV.parse(items_text, :headers => true)
items_csv.each do |row|
  Item.create(
    name:         row["name"],
    description:  row["description"],
    unit_price:   row["unit_price"],
    merchant_id:  row["merchant_id"],
    created_at:   row["created_at"],
    updated_at:   row["updated_at"]
  )
end

merchants_text = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
merchants_csv = CSV.parse(merchants_text, :headers => true)
merchants_csv.each do |row|
  Merchant.create(
    name:         row["name"],
    created_at:   row["created_at"],
    updated_at:   row["updated_at"]
  )
end

transactions_text = File.read(Rails.root.join('lib', 'seeds', 'transactions.csv'))
transactions_csv = CSV.parse(transactions_text, :headers => true)
transactions_csv.each do |row|
  Transaction.create(
    invoice_id:                     row["invoice_id"],
    credit_card_number:             row["credit_card_number"],
    credit_card_expiration_date:    row["credit_card_expiration_date"],
    result:                         row["result"],
    created_at:                     row["created_at"],
    updated_at:                     row["updated_at"]
  )
end