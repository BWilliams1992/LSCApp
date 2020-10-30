class Location < ApplicationRecord
    belongs_to :user
    has_many :clean_requests
    has_many :houses
end
