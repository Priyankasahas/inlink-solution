class TenantApplicationsController < ApplicationController
  before_filter :authenticate_user!
  authorize_actions_for TenantApplication

  layout "page"

  authority_actions :new_role_privilege => 'update'
  authority_actions :add_role_privilege => 'update'

  def index
    @applications = TenantApplication.all
  end

  def show
    @application = TenantApplication.find(params[:id])
  end

  def new
    @application = TenantApplication.new
    render "new"
  end

  def create
    @application = TenantApplication.new(application_params)
    if @application.save
      redirect_to :action => 'index'
    else
      render :new
    end
  end

  def edit
    @application = TenantApplication.find(params[:id])
    @applications = TenantApplication.all
  end

  def update
    @application = TenantApplication.find(params[:id])

    attributes = application_params
    attributes.delete(:password) if attributes[:password].blank?
    attributes.delete(:password_confirmation) if attributes[:password_confirmation].blank?

    if @application.update_attributes(attributes)
      flash[:notice] = "You have successfully updated the application."
    end

    redirect_to :action => 'show', :id => @application.id
  end

  def destroy
    @application = TenantApplication.find(params[:id]).destroy
    flash[:notice] = "You have successfully deleted the application."
    redirect_to :action => 'index'
  end

  def new_role_privilege
    @application = TenantApplication.find(params[:tenant_application_id])
  end

  def add_role_privilege
    @application = TenantApplication.find(params[:tenant_application_id])
    if @application.add_role_privilege(params["tenant_application"]["role_privilege"]["role_name"], params["tenant_application"]["role_privilege"]["privileges"].reject(&:empty?))
      redirect_to :action => 'show', :id => @application.id
    else
      flash[:error] = "This role has already been configured for the application."
      render :new_role_privilege
    end
  end

  protected

  def application_params
    params.require(:tenant_application).permit(:name, :description)
  end
end
