class Location < ApplicationRecord
    include Comparable
    belongs_to :user
    has_many :clean_requests, dependent: :destroy
    has_many :plots, dependent: :destroy
    has_many :invoices, dependent: :destroy

    has_many :cost_house_locations
    has_many :houses, :through => :cost_house_locations

    after_save :create_invoices

    private 
        def create_invoices
            @site_start_date = self.start_date
            @today  = Date.today

            @months_to_create = @today.month - @site_start_date.month

            for i in 0..@months_to_create do
                @invoice_start_date = @site_start_date >> i
                @invoice_end_date = (@site_start_date >> (i +1)).prev_day
                @invoice = Invoice.new(start_date: @invoice_start_date, end_date:@invoice_end_date,location: self)
                @invoice.save!
            end
        end
end
