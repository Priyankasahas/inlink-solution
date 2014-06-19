class RolePrivilege < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'RolePrivilegeAuthorizer'

  belongs_to :tenant_application

   serialize :privileges
end
