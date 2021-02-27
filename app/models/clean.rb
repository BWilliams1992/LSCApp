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
    raise 'Start & end time must be specified' unless start_time && end_time
    raise 'Start time must be before end time' if start_time > end_time

    (end_time - start_time) / 3600
  end

  def clean_cost
    # returns the cost of a clean according to its clean house location association
    case clean_type
    when 'Pre-Paint'
      location.cost_house_locations.find_by({ house_id: plot.house_id }).pre_paint_cost
    when 'Post-Paint'
      location.cost_house_locations.find_by({ house_id: plot.house_id }).post_paint_cost
    when 'Demo'
      location.cost_house_locations.find_by({ house_id: plot.house_id }).demo_cost
    when 'Sparkle'
      location.cost_house_locations.find_by({ house_id: plot.house_id }).sparkle_cost
    when 'Variation Order'
      (location.vo_cost * hours_worked) * num_people
    end
  end

  def stringify_address
    # Returns a string containing the locations address
    location.address1 + ' ' + location.address2 + ' ' + location.city + ' ' + location.postcode
  end

  def start_time_validation
    # Validates that start time is before end time if both are present
    errors.add :base, 'Start time is after end time' if start_time && end_time && (start_time > end_time)
  end
end
