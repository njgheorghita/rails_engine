class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

end
