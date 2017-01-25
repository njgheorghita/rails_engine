class Merchant < ApplicationRecord
  validates :name, :created_at, :updated_at, presence: true
  has_many :invoices
  has_many :items
  
  def self.random
    Merchant.order("RANDOM()").first
  end

end
