class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :transactions do |t|
      t.references :invoice
      t.string     :credit_card_number
      t.string     :credit_card_expiration_date
      t.citext     :result
      t.datetime   :created_at
      t.datetime   :updated_at
    end
  end
end
