class AddWorkPlaceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :status, :boolean
    add_column :users, :gender, :string
    add_column :users, :work_place, :string
    add_column :users, :birthday, :date
    add_column :users, :bio, :text
  end
end
