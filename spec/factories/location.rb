# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    address1 { 'Test 1' }
    address2 { 'test 2' }
    city { 'Test City' }
    county { 'Test County' }
    postcode { 'test' }
    user_id { 1 }
    site_name { 'Test Name' }
    number_of_plots { 10 }
    start_date { Date.today }
    vo_cost { 20 }
  end
end
