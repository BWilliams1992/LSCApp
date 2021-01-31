class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def new
    @invoice = Invoice.new
  end

  def create 
    @invoice = Invoice.new(invoice_params)
    if @invoice.save 
      flash[:notice] = "invoice created"
      redirect_to @invoice
    else
      render 'new'
    end
  end

  def index 
    @invoices = Invoice.all
  end

  def show
    @cleans = Clean.where({ date: @invoice.start_date..@invoice.end_date, completed: true })
  end

  def destroy 
    @invoice.destroy
    flash[:notice] = "Invoice Deleted"
    redirect_to invoices_path
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:start_date, :end_date, :location_id)
    end
end
