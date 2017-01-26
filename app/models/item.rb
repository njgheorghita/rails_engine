class Item < ApplicationRecord
  validates :name, :description, :merchant_id, :unit_price, :created_at, :updated_at, presence: true
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant, optional: true

  def self.random
    Item.order("RANDOM()").first
  end

  def self.most_revenue(quantity)
    Item
      .select("sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue, items.id, items.name")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = 'success'")
      .group("items.id, items.name")
      .order("total_revenue desc")
      .limit(quantity)
  end

end
