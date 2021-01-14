class Invoice < ApplicationRecord
  has_many :cleans
  belongs_to :location

  def completed_cost
    @total = 0
      self.cleans.each do |clean|
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
          end
        end
      end
      return @total
  end

  def pending_cost
    @total = 0
      self.cleans.each do |clean|
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
      @total = self.completed_cost + self.pending_cost
      return @total
    end
end
