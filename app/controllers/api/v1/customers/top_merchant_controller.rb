class Api::V1::Customers::TopMerchantController < ApplicationController

  def show
    render json: Customer.find(params["id"]).favorite_merchant, serializer: TopMerchantSerializer
  end

end
