class Customer < ApplicationRecord
  has_many :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

end
