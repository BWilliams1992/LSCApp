# frozen_string_literal: true

class PlotExtra < ApplicationRecord
  belongs_to :plot
  belongs_to :extra
end
