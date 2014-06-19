class RolePrivilegesController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for RolePrivilege

  layout "page"

  def edit
    @role_privilege = RolePrivilege.find(params[:id])
  end

  def update
    @role_privilege = RolePrivilege.find(params[:id])
    @application = @role_privilege.tenant_application

    @role_privilege.role_name = params["role_privilege"]["role_name"]
    @role_privilege.privileges = params["role_privilege"]["privileges"].reject(&:empty?)

    if !@application.role_privileges.where(role_name: params["role_privilege"]["role_name"]).empty? and @application.role_privileges.where(role_name: params["role_privilege"]["role_name"]).last.id != @role_privilege.id
      flash[:error] = "This role has already been configured for the application."
      render :edit, :id => @role_privilege.id
    else
      flash[:notice] = "You have successfully updated the privilege" if @role_privilege.save
      redirect_to tenant_application_path(@application)
    end
  end
end
