class Blog < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'BlogAuthorizer'

  belongs_to :user

  scope :user, -> (user_id) { where user_id: user_id }
  scope :title, -> (title) { where("title like ?", "#{title}%") }

  self.per_page = 3

  def self.roles_for(privilege)
    roles = []
    Blog.application.role_privileges.each do |rp|
      unless (rp.privileges & [privilege.to_s.titleize]).empty?
        roles << rp.role_name
      end
    end
    roles
  end

  def self.application
    TenantApplication.find_by_name("Blog")
  end
end
