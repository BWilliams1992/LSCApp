class Clean < ApplicationRecord
  belongs_to :plot

  def hours_worked 
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
