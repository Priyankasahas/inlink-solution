class RolePrivilege < ActiveRecord::Base
  belongs_to :tenant_application

   serialize :privileges
end
