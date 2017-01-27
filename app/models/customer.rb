class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

  # def favorite_merchant
  #   self.invoices.select("count(invoices.merchant_id) as transaction_count, invoices.merchant_id, merchants.name").joins(:transactions, :merchants).merge(Transaction.successful).group("invoices.merchant_id, merchants.name").order("transaction_count desc").limit(1)
  # end

end
