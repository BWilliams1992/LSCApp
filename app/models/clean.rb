class Clean < ApplicationRecord
  belongs_to :invoice
  before_validation :set_invoice
  
  def set_invoice    
    if !self.invoice
      @invoice = Invoice.find_by("start_date < ?", self.date)
      @invoice2 = Invoice.find_by("end_date > ?", self.date)
      if (@invoice === @invoice2)
        self.invoice = @invoice
      end
    end
  end
end
