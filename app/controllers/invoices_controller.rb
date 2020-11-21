class InvoicesController < ApplicationController

  def new
  end

  def create 
  end

  def index 
    @invoices = Invoice.all
  end
end
