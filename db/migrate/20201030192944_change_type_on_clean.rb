class ChangeTypeOnClean < ActiveRecord::Migration[6.0]
  def change
    rename_column :cleans, :type, :clean_type
  end
end
