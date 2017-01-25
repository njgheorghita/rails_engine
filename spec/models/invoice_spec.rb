require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without customer_id' do
        invoice = Invoice.create(merchant_id: 43, status:"hi", created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")
      
        expect(invoice).to be_invalid
      end

      it 'is invalid without merchant_id' do
        invoice = Invoice.create(customer_id:4, status:"hi", created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")
        
        expect(invoice).to be_invalid
      end

      it 'is invalid without status' do
        invoice = Invoice.create(customer_id:4, merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice).to be_invalid
      end

      it 'is invalid without created_at' do 
        invoice = Invoice.create(customer_id:4, merchant_id: 43, status:"hi", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice).to be_invalid
      end

      it 'is invalid without updated_at' do 
        invoice = Invoice.create(customer_id:4, merchant_id: 43, status:"hi", created_at:  "2009-03-25 09:54:09 UTC")

        expect(invoice).to be_invalid
      end
    end 

    context 'valid attributes' do 
      it 'is valid with all attributes' do 
        invoice = Invoice.create(customer_id:4, merchant_id: 43, status:"hi", created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice).to be_valid
      end
    end
  end
end
        
        
