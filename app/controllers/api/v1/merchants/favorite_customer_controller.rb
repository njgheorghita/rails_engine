class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Invoice.where(merchant_id:params[:id]).favorite_customer
  end

end