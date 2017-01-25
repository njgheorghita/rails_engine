require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do 
    context 'invalid attributes' do 
      it 'is invalid without a name' do 
        item = Item.create(description:"Porgy", unit_price: 4, merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_invalid
      end

      it 'is invalid without a description' do 
        item = Item.create(name:"George", unit_price: 4, merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_invalid
      end  

      it 'is invalid without a unit_price' do 
        item = Item.create(name:"George", description:"Porgy", merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_invalid
      end

      it 'is invalid without a merchant_id' do 
        item = Item.create(name:"George", description:"Porgy", unit_price: 4, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_invalid
      end

      it 'is invalid without created_at' do 
        item = Item.create(name:"George", description:"Porgy", unit_price: 4, merchant_id: 43, updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_invalid
      end

      it 'is invalid without updated_at' do 
        item = Item.create(name:"George", description:"Porgy", unit_price: 4, merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC")

        expect(item).to be_invalid
      end
    end

    context 'valid attributes' do 
      it 'is valid with all attributes' do 
        item = Item.create(name:"George", description:"Porgy", unit_price: 4, merchant_id: 43, created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC" )

        expect(item).to be_valid
      end
    end
  end
end

