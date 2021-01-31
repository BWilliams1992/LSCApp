class Clean < ApplicationRecord
  validates :start_time, presence: true, if: -> {self.completed?}
  validates :end_time, presence: true, if: -> {self.completed?}
  belongs_to :plot
  belongs_to :location

  def extras_total
    #Calculates the total cost of any extras associated with the plot that the clean is associated with
    if self.plot.plot_extras
      @total = 0
      self.plot.plot_extras.each do |plot_extra|
        @total += plot_extra.extra.cost
      end
      return @total
    end
  end

  def hours_worked 
    #Calculates the hours worked from start and end time of a clean
    if(self.start_time && self.end_time)
      if (self.start_time < self.end_time)
        return (self.end_time - self.start_time)/ 3600
      else
        return "Start time after end time"
      end
    else
      return "No start or end time"
    end
  end

end
