class InvoiceItem < ApplicationRecord
  validates :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, presence: true
  belongs_to :item, optional: true
  belongs_to :invoice, optional: true

  def self.random
    InvoiceItem.order("RANDOM()").first
  end

end
