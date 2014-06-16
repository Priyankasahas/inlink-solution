class UsersController < ApplicationController
  # before_filter :authenticate_user!

  layout "page"

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @roles = @user.roles
  end

  def new
    @user = User.new
    render "new"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :action => 'show', :id => @user.id, :notice => "Signed up!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @applications = TenantApplication.all
  end

  def update
    @user = User.find(params[:id])

    attributes = user_params
    attributes.delete(:password) if attributes[:password].blank?
    attributes.delete(:password_confirmation) if attributes[:password_confirmation].blank?

    if @user.update_attributes(attributes)
      flash[:notice] = "You have successfully updated the user"
    end

    redirect_to :action => 'show', :id => @user.id
  end

  def new_role
    @user = User.find(params[:user_id])
  end

  def add_role
    @user = User.find(params[:user_id])
    app_ids = params["user"]["role"]["resource_id"].reject(&:empty?)
    app_ids.each do |app_id|
      app = TenantApplication.find(app_id)
      @user.add_role params["user"]["role"]["name"].to_sym, app
    end

    redirect_to :action => 'show', :id => @user.id
  end

  def remove_role
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    @role.destroy
    flash[:notice] = "You have successfully deleted the role"

    redirect_to :action => 'show', :id => @user.id
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:notice] = "You have successfully deleted the user"
    redirect_to :action => 'index'
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :surname, :email, :password, :salt, :encrypted_password)
  end
end
