class Plot < ApplicationRecord
  belongs_to :location

  def self.default_scope
    order(created_at: :asc)
  end
end
