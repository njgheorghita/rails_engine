class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  
  def self.random
    Merchant.order("RANDOM()").first
  end

end
