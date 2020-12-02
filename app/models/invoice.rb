class Invoice < ApplicationRecord
  has_many :cleans
  belongs_to :location
end
