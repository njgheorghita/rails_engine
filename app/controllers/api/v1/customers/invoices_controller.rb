class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    # current_id = Customer.find(params[:id])
    # render json: Invoice.where(customer_id: current_id)
    render json: Customer.find(params[:id]).invoices
  end

end
