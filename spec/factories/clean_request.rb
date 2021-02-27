# frozen_string_literal: true

FactoryBot.define do
  factory :clean_request do
    date { Date.parse('15/01/2021') }
    approved { false }
    clean_type { 'Build' }
    location_id {}
    plot_number {'1'}
    notes {}
    user_id {}
  end
end
