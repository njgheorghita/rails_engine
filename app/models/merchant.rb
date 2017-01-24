class Merchant < ApplicationRecord

  def self.random
    Merchant.order("RANDOM()").first
  end

end
