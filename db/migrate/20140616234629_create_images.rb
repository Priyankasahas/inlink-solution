class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string     :alt,  :string
      t.string     :hint, :string
      t.attachment :file
      t.timestamps
    end
  end
end
