class House < ApplicationRecord
    validates :sales_name, presence:true
    validates :build_number, presence:true
    has_many :cost_house_locations
    has_many :locations, :through => :cost_house_locations
end
