# frozen_string_literal: true

class CleanRequest < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_one :clean

  before_validation :convert_to_clean

  after_update :approved_check

  def approved_check
    UserMailer.with(clean_request: self, user: user).clean_request_approval_change_email.deliver_now if approved
  end

  def convert_to_clean
    unless clean
      @clean = Clean.new(
        date: date,
        location_id: location_id,
        plot_id: location.plots.find_by(number: plot_number).id,
        clean_type: clean_type,
        clean_request: self,
        completed: false
      )
      puts @clean.set_invoice
      @clean.save!
      self.clean = @clean

    end
  end
end
