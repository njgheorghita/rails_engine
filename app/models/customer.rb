class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

  def favorite_merchant(customer_id)
    Merchant
      .select("merchants.id, merchants.name")
      .joins(invoices: :transactions)
      .where("invoices.customer_id = ?", customer_id)
      .group("merchants.id")
      .order("count(invoices.merchant_id) desc")
      .first
  end

end
