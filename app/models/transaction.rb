class Transaction < ApplicationRecord

  def self.random
    Transaction.order("RANDOM()").first
  end

end
