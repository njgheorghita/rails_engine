class InvoiceItem < ApplicationRecord

  def self.random
    InvoiceItem.order("RANDOM()").first
  end

end
