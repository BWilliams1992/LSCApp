# frozen_string_literal: true

class CleanRequest < ApplicationRecord

  validate :date_24_hours_in_advance

  belongs_to :user
  belongs_to :location
  has_one :clean

  after_update :approved_check

  def date_24_hours_in_advance
    @today = Date.today
    if !((@today + 1 ) <= date) 
      errors.add :base, 'Date must be at least a day in advance'
    end
  end

  def approved_check
    UserMailer.with(clean_request: self, user: user).clean_request_approval_change_email.deliver_now if approved
  end

  def convert_to_clean
      @clean = Clean.new(
        date: date,
        location_id: location_id,
        plot_id: location.plots.find_by(number: plot_number).id,
        clean_type: clean_type,
        clean_request: self,
        completed: false
      )
  end

end
