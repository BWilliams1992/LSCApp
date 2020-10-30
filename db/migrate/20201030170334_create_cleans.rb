class CreateCleans < ActiveRecord::Migration[6.0]
  def change
    create_table :cleans do |t|
      t.date :date
      t.references :location, foreign_key: true
      t.integer :plot
      t.references :house, foreign_key: true
      t.boolean :completed
      t.string :type

      t.timestamps
    end
  end
end
