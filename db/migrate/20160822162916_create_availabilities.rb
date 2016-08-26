class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.string :comment
      t.datetime :min_date
      t.datetime :max_date
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
