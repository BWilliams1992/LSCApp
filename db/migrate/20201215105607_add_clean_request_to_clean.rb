class AddCleanRequestToClean < ActiveRecord::Migration[6.0]
  def change
    add_reference :cleans, :clean_request, foreign_key: true
  end
end
