class Transaction < ApplicationRecord
  validates :invoice_id, :credit_card_number, :result, :created_at, :updated_at, presence: true
  belongs_to :invoice, optional: true
  scope :successful, -> { where(result: "success")}

  def self.random
    Transaction.order("RANDOM()").first
  end

end
