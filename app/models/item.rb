class Item < ApplicationRecord
  validates :name, :description, :merchant_id, :unit_price, :created_at, :updated_at, presence: true
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant, optional: true

  def self.random
    Item.order("RANDOM()").first
  end

end
