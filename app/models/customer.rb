class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.random
    Customer.order("RANDOM()").first
  end

end
