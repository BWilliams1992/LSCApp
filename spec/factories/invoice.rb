FactoryBot.define do
  factory :invoice do
    start_date {Date.parse("01/01/2021")}
    end_date {Date.parse("31/01/2021")}
    location_id {1}
  end
end