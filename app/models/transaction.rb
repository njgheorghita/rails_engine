class Transaction < ApplicationRecord
  belongs_to :invoice, optional: true

  def self.random
    Transaction.order("RANDOM()").first
  end

end
