class UserAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    return true if user.is_admin?
    false
  end

  def self.creatable_by?(user)
    return true if user.is_admin?
    false
  end

  def self.updatable_by?(user)
    return true if user.is_admin?
    false
  end

  def self.deletable_by?(user)
    return true if user.is_admin?
    false
  end
end