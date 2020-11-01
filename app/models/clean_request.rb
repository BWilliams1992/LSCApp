class CleanRequest < ApplicationRecord
    belongs_to :user
    belongs_to :location
    has_many :cleans, dependent: :destroy
end
