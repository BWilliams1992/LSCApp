# frozen_string_literal: true

class Plot < ApplicationRecord
  belongs_to :location
  has_many :cleans
  has_many :plot_extras
  has_many :extras, through: :plot_extras

  def self.default_scope
    order(created_at: :asc)
  end
end
