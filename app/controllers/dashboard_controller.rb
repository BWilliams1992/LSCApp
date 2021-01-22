class DashboardController < ApplicationController
  def index
    @today = Date.today
    @today_cleans = Clean.where({date:@today})
    @month_cleans = Clean.where('extract(month from date) = ?', @today.month)

  end
end
