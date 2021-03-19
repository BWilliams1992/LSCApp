# frozen_string_literal: true

class Location < ApplicationRecord
  include Comparable
  validates :site_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :postcode, presence: true
  validates :number_of_plots, presence: true
  validates :start_date, presence: true

  belongs_to :user
  has_many :clean_requests, dependent: :destroy
  has_many :plots, dependent: :destroy
  has_many :invoices, dependent: :destroy

  has_many :cost_house_locations
  has_many :houses, through: :cost_house_locations

  has_one_attached :layout

  after_create :create_plots, :create_invoices
  after_update :check_default_house_and_update

  private

  def check_default_house_and_update
    if self.house_id
      self.plots.each do |plot|
        if !plot.house_id
          plot.house_id = self.house_id
          plot.save
        end
      end
    end
  end
  
  def create_plots
    (1..number_of_plots).each do |i|
      plots.create(number: i)
    end
  end

  def create_invoices
    @site_start_date = start_date
    @today = Date.today

    @months_to_create = @today.month - @site_start_date.month

    (0..@months_to_create).each do |i|
      @invoice_start_date = @site_start_date >> i
      @invoice_end_date = (@site_start_date >> (i + 1)).prev_day
      @invoice = Invoice.new(start_date: @invoice_start_date, end_date: @invoice_end_date, location: self)
      @invoice.save!
    end
  end
end
