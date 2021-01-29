class Invoice < ApplicationRecord
  
  belongs_to :location
  
  def completed_cost
    #Returns the total cost of completed cleans 
    @total = 0
      invoice_cleans.each do |clean|
        @location = self.location
        @plot = Plot.find(clean.plot_id)
        @house = House.find(@plot.house_id)
        @cost_house_location = CostHouseLocation.find_by( location: @location, house: @house )
        if clean.completed 
          if clean.clean_type == 'Sparkle'
            @total += @cost_house_location.sparkle_cost
          elsif clean.clean_type == 'Demo'
            @total += @cost_house_location.demo_cost
          elsif clean.clean_type == 'Pre-Paint'
            @total += @cost_house_location.pre_paint_cost
          elsif clean.clean_type == 'Post-Paint'
            @total += @cost_house_location.post_paint_cost
          elsif clean.clean_type == 'Variation Order'
            @total += (clean.location.vo_cost * clean.hours_worked) * clean.num_people
          end

          clean.plot.plot_extras.each do |plot_extra|
            @total += plot_extra.extra.cost
          end

        end
      end
      return @total
  end

  def pending_cost
    #Returns the total cost of pending cleans 
    @total = 0
      invoice_cleans.each do |clean|
        @location = self.location
        @plot = Plot.find(clean.plot_id)
        @house = House.find(@plot.house_id)
        @cost_house_location = CostHouseLocation.find_by( location: @location, house: @house )
        if !clean.completed 
          if clean.clean_type == 'Sparkle'
            @total += @cost_house_location.sparkle_cost
          elsif clean.clean_type == 'Demo'
            @total += @cost_house_location.demo_cost
          elsif clean.clean_type == 'Pre-Paint'
            @total += @cost_house_location.pre_paint_cost
          elsif clean.clean_type == 'Post-Paint'
            @total += @cost_house_location.post_paint_cost
          end
        end
      end
      return @total
  end

  def total_cost 
    #Returns the total cost of all associated cleans 
    @total = self.completed_cost + self.pending_cost
    return @total
  end

  def invoice_cleans
    #Returns an ActiveModel collection of cleans that are within the start and end dates of the invoice
    @site_cleans = Clean.where(location_id: self.location_id)
    @site_start_date_cleans = @site_cleans.where('date >= ?', self.start_date)
    @site_month_cleans = @site_start_date_cleans.where('date <= ?', self.end_date)

    return @site_month_cleans
  end
end
