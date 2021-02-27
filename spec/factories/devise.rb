# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'test@user.com' }
    password { 'qwerty' }
    admin { true }
    staff { false }
  end
end
