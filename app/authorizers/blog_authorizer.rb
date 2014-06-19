class BlogAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    return true if user.is_admin?

    roles = Blog.roles_for("read")

    roles.each do |role|
      if user.has_role? role.downcase.to_sym, Blog.application
        return true
      end
    end
    false
  end

  def self.creatable_by?(user)
    return true if user.is_admin?

    roles = Blog.roles_for("create")

    roles.each do |role|
      if user.has_role? role.downcase.to_sym, Blog.application
        return true
      end
    end
    false
  end

  def self.updatable_by?(user)
    return true if user.is_admin?

    roles = Blog.roles_for("update")

    roles.each do |role|
      if user.has_role? role.downcase.to_sym, Blog.application
        return true
      end
    end
    false
  end

  def self.deletable_by?(user)
    return true if user.is_admin?

    roles = Blog.roles_for("delete")

    roles.each do |role|
      if user.has_role? role.downcase.to_sym, Blog.application
        return true
      end
    end
    false
  end

end