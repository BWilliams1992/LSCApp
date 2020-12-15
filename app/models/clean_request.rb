class CleanRequest < ApplicationRecord
    belongs_to :user
    belongs_to :location
    has_one :clean

    before_validation :convert_to_clean

    after_update :approved_check

    def approved_check
        if self.approved 
            UserMailer.with(clean_request: self, user: self.user).clean_request_approval_change_email.deliver_now

        end
    end

    def convert_to_clean
        if !self.clean
                @clean = Clean.new(
                    date: self.date, 
                    location_id: self.location_id,
                    plot_id: self.location.plots.find_by(number: self.plot_number).id,
                    clean_type: self.clean_type,
                    clean_request: self,
                    completed: false,
                )
                puts @clean.set_invoice
                @clean.save!
                self.clean = @clean

        end
    end

end
