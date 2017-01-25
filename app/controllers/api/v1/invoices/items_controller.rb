class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    render json: Invoice.where(invoice_id: params[:id])
  end

end
