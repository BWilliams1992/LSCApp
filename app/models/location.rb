class Location < ApplicationRecord
    belongs_to :user
    has_many :clean_requests, dependent: :destroy
    has_many :plots, dependent: :destroy
end
