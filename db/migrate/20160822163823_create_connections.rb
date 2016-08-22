class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.string :status
      t.references :guest
      t.references :host

      t.timestamps
    end
  end
end
