class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.random
    Transaction.order("RANDOM()").first
  end

end
