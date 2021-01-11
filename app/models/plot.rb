class Plot < ApplicationRecord
  belongs_to :location
  has_many :cleans

  def self.default_scope
    order(created_at: :asc)
  end
end
