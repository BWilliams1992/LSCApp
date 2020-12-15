class ChangePlotOnCleans < ActiveRecord::Migration[6.0]
  def change
    change_column :cleans, :plot, :string
  end
end
