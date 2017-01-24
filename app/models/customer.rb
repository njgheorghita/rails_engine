class Customer < ApplicationRecord

  def self.random
    Customer.order("RANDOM()").first
  end

end
