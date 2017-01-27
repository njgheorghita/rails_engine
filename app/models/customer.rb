class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

  def self.favorite_customer(merchant_id)
    Customer.select("customers.id").joins(invoices: :transactions).merge(Transaction.successful).where("invoices.merchant_id = ?", merchant_id).group("customers.id").order("count(invoices.customer_id) desc").first
  end

end
