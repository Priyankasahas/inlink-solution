class BlogsController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for Blog

  layout "page"

  def index
    @blogs = Blog.all.paginate(:page => params[:page]).order('created_at DESC')
    filtering_params(params).each do |key, value|
      @blogs = @blogs.public_send(key, value) if value.present?
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "The blog has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update_attributes(blog_params)
      redirect_to blogs_path, notice: "The blog has been updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @blog = Blog.find(params[:id]).destroy
    flash[:notice] = "You have successfully deleted the blog"
    redirect_to :action => 'index'
  end

  protected

  def blog_params
    params.require(:blog).permit(:title, :body, :user_id)
  end

  def filtering_params(params)
    params.slice(:user_id, :title)
  end

  def current_user_roles
    app = TenantApplication.find_by_name("Blogs")
    user_roles = current_user.roles.where(resource: app)
    unless user_roles.empty?
      roles = []
      user_roles.each do |ur|
        roles << ur.name
      end
      roles
    else
      nil
    end
  end

end
