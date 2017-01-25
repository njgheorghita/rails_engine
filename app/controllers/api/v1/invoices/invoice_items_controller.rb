class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    render json: Invoice.where(invoice_id: params[:id])
  end

end
