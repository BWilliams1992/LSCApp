class AddNumberToPlots < ActiveRecord::Migration[6.0]
  def change
    add_column :plots, :number, :int
  end
end
