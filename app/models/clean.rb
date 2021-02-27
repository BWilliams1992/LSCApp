# frozen_string_literal: true

class Clean < ApplicationRecord

  validates :start_time, presence: true, if: -> { completed? }
  validates :end_time, presence: true, if: -> { completed? }
  validate :start_time_validation
  belongs_to :plot
  belongs_to :location

  def extras_total
    # Calculates the total cost of any extras associated with the plot that the clean is associated with
    if plot.plot_extras
      @total = 0
      plot.plot_extras.each do |plot_extra|
        @total += plot_extra.extra.cost
      end
      @total
    end
  end

  def hours_worked
    # Calculates the hours worked from start and end time of a clean
    raise "Start & end time must be specified" unless start_time && end_time
    raise "Start time must be before end time" if start_time > end_time
    (end_time - start_time) / 3600
  end

  def clean_cost
      #returns the cost of a clean according to its clean house location association 
      case self.clean_type
      when "Pre-Paint"
        return self.location.cost_house_locations.find_by({house_id: Plot.find(self.plot_id).house_id}).pre_paint_cost
      when "Post-Paint"
        return self.location.cost_house_locations.find_by({house_id: Plot.find(self.plot_id).house_id}).post_paint_cost
      when "Demo"
        return self.location.cost_house_locations.find_by({house_id: Plot.find(clean.plot_id).house_id}).demo_cost
      when "Sparkle"
        return self.location.cost_house_locations.find_by({house_id: Plot.find(self.plot_id).house_id}).sparkle_cost
      when "Variation Order"
        return (self.location.vo_cost * self.hours_worked) * self.num_people
      end
  end

  def stringify_address
    return location.address1 + ' ' + location.address2 + ' ' + location.city + ' ' + location.postcode
  end

  def start_time_validation
    if self.start_time && self.end_time 
      if self.start_time > self.end_time 
        errors.add :base, 'Start time is after end time'
      end
    end
  end

end
