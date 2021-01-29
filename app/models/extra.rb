class Extra < ApplicationRecord
  has_many :plot_extras
  has_many :plots, :through => :plot_extras
end
