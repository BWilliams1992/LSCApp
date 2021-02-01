FactoryBot.define do
  factory :cost_house_location do
    pre_paint_cost {100}
    post_paint_cost {90}
    demo_cost {90}
    sparkle_cost {80}
    house_id { }
    location_id { }
  end
end