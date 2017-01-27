class Api::V1::Customers::TopMerchantController < ApplicationController

  def show
    render json: Merchant.favorite_merchant(params[:id])
  end

end
