class CreateTenantApplications < ActiveRecord::Migration
  def change
    create_table :tenant_applications do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
