class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.string :comment
      t.string :min_day
      t.string :max_day
      t.time :min_time
      t.time :max_time
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
