class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions
  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true
  
  def self.random
    Invoice.order("RANDOM()").first
  end

end
