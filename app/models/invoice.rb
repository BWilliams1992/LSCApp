class Invoice < ApplicationRecord
  has_many :cleans
  belongs_to :location

    def total_cost 
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
          elsif clean.clean_type == 'Build'
            @total += @cost_house_location.build_cost
          end
        end
      end
      return @total
    end
end
