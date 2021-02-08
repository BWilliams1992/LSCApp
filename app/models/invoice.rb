# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :location

  def completed_cost
    # Returns the total cost of completed cleans
    @total = 0
    invoice_cleans.each do |clean|
      @location = location
      @plot = Plot.find(clean.plot_id)
      @house = House.find(@plot.house_id)
      @cost_house_location = CostHouseLocation.find_by(location: @location, house: @house)
      next unless clean.completed

      case clean.clean_type
      when 'Sparkle'
        @total += @cost_house_location.sparkle_cost
      when 'Demo'
        @total += @cost_house_location.demo_cost
      when 'Pre-Paint'
        @total += @cost_house_location.pre_paint_cost
      when 'Post-Paint'
        @total += @cost_house_location.post_paint_cost
      when 'Variation Order'
        @total += (clean.location.vo_cost * clean.hours_worked) * clean.num_people
      end

      clean.plot.plot_extras.each do |plot_extra|
        @total += plot_extra.extra.cost
      end
    end
    @total
  end

  def pending_cost
    # Returns the total cost of pending cleans
    @total = 0
    invoice_cleans.each do |clean|
      @location = location
      @plot = Plot.find(clean.plot_id)
      @house = House.find(@plot.house_id)
      @cost_house_location = CostHouseLocation.find_by(location: @location, house: @house)
      next if clean.completed

      case clean.clean_type
      when 'Sparkle'
        @total += @cost_house_location.sparkle_cost
      when 'Demo'
        @total += @cost_house_location.demo_cost
      when 'Pre-Paint'
        @total += @cost_house_location.pre_paint_cost
      when 'Post-Paint'
        @total += @cost_house_location.post_paint_cost
      end
    end
    @total
  end

  def total_cost
    # Returns the total cost of all associated cleans
    @total = completed_cost + pending_cost
    @total
  end

  def invoice_cleans
    # Returns an ActiveModel collection of cleans that are within the start and end dates of the invoice
    @site_cleans = Clean.where(location_id: location_id)
    @site_start_date_cleans = @site_cleans.where('date >= ?', start_date)
    @site_month_cleans = @site_start_date_cleans.where('date <= ?', end_date)

    @site_month_cleans
  end
end
