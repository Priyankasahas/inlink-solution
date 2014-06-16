class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :User, :first_name, :string
    add_column :User, :surname, :string
  end
end
