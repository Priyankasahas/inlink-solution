class CreateRolePrivileges < ActiveRecord::Migration
  def change
    create_table :role_privileges do |t|
      t.string :role_name
      t.text :privileges

      t.references :tenant_application

      t.timestamps
    end
  end
end
