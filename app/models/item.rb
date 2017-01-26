class Item < ApplicationRecord
  validates :name, :description, :merchant_id, :unit_price, :created_at, :updated_at, presence: true
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant, optional: true

  def self.random
    Item.order("RANDOM()").first
  end

  def self.top_items_by_items_sold(quantity)
    Item
    .select("items.*, sum(invoice_items.quantity) as total_items_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group("items.id, items.name")
    .order("total_items_sold desc")
    .limit(quantity)
  end

end
