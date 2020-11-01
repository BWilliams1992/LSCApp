class Clean < ApplicationRecord
  belongs_to :location
  belongs_to :house
  belongs_to :clean_request
end
