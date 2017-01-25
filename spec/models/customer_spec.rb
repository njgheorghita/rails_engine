require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    context 'invalid attributes' do 
      it 'is invalid without a first_name' do
        customer = Customer.create(last_name: "George", created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")
      
        expect(customer).to be_invalid
      end

      it 'is invalid without a last_name' do
        customer = Customer.create(first_name: "George", created_at:  "2009-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(customer).to be_invalid
      end

      it 'is invalid without a created_at' do
        customer = Customer.create(first_name: "George", last_name: "Michael", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(customer).to be_invalid
      end

      it 'is invalid without a updated_at' do
        customer = Customer.create(first_name: "George", last_name: "Michael", created_at:  "2010-03-25 09:54:09 UTC")

        expect(customer).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with all attributes' do
        customer = Customer.create(first_name: "George", last_name: "Michael", created_at:  "2010-03-25 09:54:09 UTC", updated_at:  "2010-03-25 09:54:09 UTC")

        expect(customer).to be_valid
      end
    end
  end
end
