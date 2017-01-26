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
  #   merchants
  #   .select("merchants.*, count(invoices.merchant_id) as invoice_count")
  #   .joins(:transactions)
  #   .where(transactions:{result: 'success'})
  #   .group(:id)
  #   .order("invoice_count desc")
  #   .first
  # end

end
