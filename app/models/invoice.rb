class Invoice < ApplicationRecord

  def self.random
    Invoice.order("RANDOM()").first
  end

end
