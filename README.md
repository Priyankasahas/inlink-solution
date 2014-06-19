Welcome!
This is a solution to InLink's ruby programming challenge.

The database design includes the below tables:

- User: has_many :blogs

- TenantApplication: (Blogger, Website, Contacts Manager, Leasing, etc...) has_many :role_privileges

- Role: (User Role for an application: Location Manager, Concierige, Content Administrator, Tenant)

- RolePrivilege: (Privilege(CRUD) per role for an application) belongs_to :tenant_application

- Blog: (Blogger Application) belongs_to :user

Instructions to use this application:

Please migrate the database to let application access these tables: rake db:migrate

Please seed the database: rake db:seed

Install gems.

Login using the below details.

Email: y.yalda@inlink.com.au

Password: testing123

Being an admin, you have rights to manage Users. Tenant applications can be managed by an administrator or a content administrator (This is hard coded in user model). Based on these permissions, a user can access the Blog application.

Gemfile:

The application is written in Ruby 2.1.1, Rails 4.1.1.

Devise: authenticates users.

Rolify: manages user roles per application.

Authority: manages the access based on the user roles and application privileges for the respective role.

Simple form: Forms

Bootstrap: Layouts

TimyMCE: WYSIWYG javascript interface to write blogs.

Paper Clip: Upload images to blogs

