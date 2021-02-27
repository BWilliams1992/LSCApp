# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id {  }
    email { 'test@user.com' }
    password { 'qwerty' }
    admin { false }
    staff { false }
  end
end
