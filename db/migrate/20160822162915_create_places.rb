class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :phone_number
      t.string :type_partner
      t.integer :pax
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
