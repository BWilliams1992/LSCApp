FactoryBot.define do
  factory :clean do
    date {Date.today}
    completed {false}
    clean_type {"Build"}
    location_id {}
    plot_id {}
    invoice {}
  end
end
