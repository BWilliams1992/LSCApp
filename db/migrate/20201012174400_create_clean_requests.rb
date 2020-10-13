class CreateCleanRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :clean_requests do |t|

      t.timestamps
    end
  end
end
