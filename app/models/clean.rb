class Clean < ApplicationRecord
  belongs_to :invoice
  
  before_validation :set_invoice
  
  def set_invoice    
    if !self.invoice
      @invoices = Location.find(self.location_id).invoices
      self.invoice = @invoices.find_by("end_date > ?", self.date)
    end
  end
end
