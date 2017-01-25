require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do 
    context 'invalid attributes' do 
      it 'is invalid without a name' do 
        merchant = Merchant.create(created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")
      
        expect(merchant).to be_invalid
      end
      
      it 'is invalid without a created_at' do 
        merchant = Merchant.create(name:"George", updated_at:  "2010-03-25 09:54:09 UTC")
      
        expect(merchant).to be_invalid
      end
      
      it 'is invalid without a updated_at' do 
        merchant = Merchant.create(name:"George", created_at:  "2009-03-25 09:54:09 UTC")
      
        expect(merchant).to be_invalid
      end
    end

    context 'valid attributes' do 
      it 'is valid with all attributes' do 
        merchant = Merchant.create(name:"George", created_at: "2009-03-25 09:54:09 UTC", updated_at: "2010-03-25 09:54:09 UTC")

        expect(merchant).to be_valid
      end
    end
  end
end
