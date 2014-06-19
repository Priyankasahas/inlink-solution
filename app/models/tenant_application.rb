class TenantApplication < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  self.authorizer_name = 'TenantApplicationAuthorizer'

  has_many :role_privileges

  def add_role_privilege(role_name, privileges)
    if self.role_privileges.where(role_name: role_name).empty?
      @role_privilege = self.role_privileges.build
      @role_privilege.role_name = role_name
      @role_privilege.privileges = privileges

      @role_privilege.save
    else
      return false
    end
  end

end
