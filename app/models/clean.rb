# frozen_string_literal: true

class Clean < ApplicationRecord
  validates :start_time, presence: true, if: -> { completed? }
  validates :end_time, presence: true, if: -> { completed? }
  validates :end_time, numericality: { greater_than: :start_time, message: "must be after Start time" }
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
    if start_time && end_time
      if start_time < end_time
        (end_time - start_time) / 3600
      else
        'Start time after end time'
      end
    else
      'No start or end time'
    end
  end
end
