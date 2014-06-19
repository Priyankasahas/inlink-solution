class User < ActiveRecord::Base
  rolify

  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_confirmation_of :password, :on => :create
  validates_presence_of :first_name, :surname
  validates_uniqueness_of :email

  has_many :blogs

  def is_admin?
    self.has_role? :administrator
  end

  def roles_for_app(app_name)
    app = TenantApplication.find_by_name(app_name)
    self.roles.where(resource: app).map { |role| role.name }
  end

  def can_manage_applications
    self.is_admin? or self.has_role? :content_administrator, Blog.application
  end
end
