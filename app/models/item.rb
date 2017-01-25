class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant, optional: true

  def self.random
    Item.order("RANDOM()").first
  end

end
