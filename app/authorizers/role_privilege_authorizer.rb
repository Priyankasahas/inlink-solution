class RolePrivilegeAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    return true if user.can_manage_applications
    false
  end

  def self.creatable_by?(user)
    return true if user.can_manage_applications
    false
  end

  def self.updatable_by?(user)
    return true if user.can_manage_applications
    false
  end

  def self.deletable_by?(user)
    return true if user.can_manage_applications
    false
  end
end