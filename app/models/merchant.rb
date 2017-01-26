class Merchant < ApplicationRecord
  validates :name, :created_at, :updated_at, presence: true
  has_many :customers, through: :invoices
  has_many :invoices
  has_many :items
  
  def self.random
    Merchant.order("RANDOM()").first
  end

  def self.top_merchants_by_revenue(quantity)
    Merchant
      .select("sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue, merchants.id, merchants.name")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group("merchants.id, merchants.name")
      .order("total_revenue desc")
      .limit(quantity)
  end

  def self.revenue(merchant_id)
    Merchant
      .find(merchant_id)
      .invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_by_date(date)
    byebug
    Merchant.joins(invoices: [:invoice_items, :transactions]).merge(Transaction.successful).where("transactions.created_at = ?", date).sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def favorite_customer
    var = 1
    # Merchant
    #   .find(merchant_id)
    #   .invoices
    #   .joins(:transactions)
    #   .where(transactions:{result:"success"})

    #   .group(:customer_id)
    #   .count
   
    # Merchant
    #   .select("count(invoices.customer_id) as customer_transactions")
    #   .joins(invoices: :transactions)
    #   .where(transactions:{result:"success"})
    #   .where("invoices.merchant_id = ?", merchant_id)

    #   works till here

    #   .group("")
    #   .limit(1)
  end
end