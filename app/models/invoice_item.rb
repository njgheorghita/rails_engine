class InvoiceItem < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :invoice, optional: true

  def self.random
    InvoiceItem.order("RANDOM()").first
  end

end
