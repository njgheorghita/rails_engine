require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without an item_id' do
        invoice_item = InvoiceItem.create(invoice_id:1, quantity:3, unit_price:4, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end

      it 'is invalid without an invoice_id' do
        invoice_item = InvoiceItem.create(item_id:1, quantity:3, unit_price:4, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end

      it 'is invalid without a quantity' do
        invoice_item = InvoiceItem.create(item_id:1, invoice_id:3, unit_price:4, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end

      it 'is invalid without a unit_price' do
        invoice_item = InvoiceItem.create(item_id:1, invoice_id:3, quantity:4, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end

      it 'is invalid without a created_at' do
        invoice_item = InvoiceItem.create(item_id:1, invoice_id:3, quantity:4, unit_price:3, updated_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end

      it 'is invalid without an updated_at' do
        invoice_item = InvoiceItem.create(item_id:1, invoice_id:3, quantity:4, unit_price:3, created_at:  "2010-03-25 09:54:09 UTC")

        expect(invoice_item).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with all attributes' do
        invoice_item = InvoiceItem.create(item_id:1, invoice_id:3, quantity:4, unit_price:3, created_at:  "2010-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")
        
        expect(invoice_item).to be_valid
      end
    end
  end
end
