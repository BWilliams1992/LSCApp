FactoryBot.define do
  factory :clean do
    date {Date.parse("15/01/2021")}
    completed {false}
    clean_type {"Build"}
    location_id {}
    plot_id {}
    start_time {Time.parse("09:00")}
    end_time {Time.parse("12:00")}
    num_people { 1 }
  end
end
