require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do 
    context 'invalid attributes' do 
      it 'is invalid without invoice_id' do 
        transaction = Transaction.create(credit_card_number: 533, credit_card_expiration_date: 43, result:"success", created_at: "2009-03-25 09:54:09 UTC", updated_at: "2010-03-25 09:54:09 UTC")
      
        expect(transaction).to be_invalid
      end
      
      it 'is invalid without credit_card_number' do 
        transaction = Transaction.create(invoice_id:4, credit_card_expiration_date: 43, result:"success", created_at: "2009-03-25 09:54:09 UTC", updated_at: "2010-03-25 09:54:09 UTC")
      
        expect(transaction).to be_invalid
      end
      
      it 'is invalid without result' do 
        transaction = Transaction.create(invoice_id:4, credit_card_number: 533, credit_card_expiration_date: 43, created_at: "2009-03-25 09:54:09 UTC", updated_at: "2010-03-25 09:54:09 UTC")
      
        expect(transaction).to be_invalid
      end
      
      it 'is invalid without created_at' do 
        transaction = Transaction.create(invoice_id:4, credit_card_number: 533, credit_card_expiration_date: 43, result:"success", updated_at: "2010-03-25 09:54:09 UTC")
      
        expect(transaction).to be_invalid
      end
      
      it 'is invalid without updated_at' do 
        transaction = Transaction.create(invoice_id:4, credit_card_number: 533, credit_card_expiration_date: 43, result:"success", created_at: "2009-03-25 09:54:09 UTC")
      
        expect(transaction).to be_invalid
      end
    end

    context 'valid attributes' do 
      it 'is valid with all attributes' do
        transaction = Transaction.create(invoice_id:4, credit_card_number: 533, credit_card_expiration_date: 43, result:"success", created_at: "2009-03-25 09:54:09 UTC", updated_at: "2010-03-25 09:54:09 UTC")
      
        expect(transaction).to be_valid
      end
    end
  end
end
