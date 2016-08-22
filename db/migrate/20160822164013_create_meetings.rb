class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.text :guest_review
      t.text :host_review
      t.datetime :date
      t.references :connection, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
