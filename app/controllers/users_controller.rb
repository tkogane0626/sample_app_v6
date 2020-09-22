class UsersController < ApplicationController
  
  # beforeフィルター
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  # GET /users(.:format)
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id(.:format)
  def show
    @user = User.find(params[:id])
  end
  
  # GET /signup(.:format)
  def new
    @user = User.new(params[:user])
  end
  
  # POST /users(.:format) 
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # GET /users/:id/edit(.:format)
  def edit
    @user = User.find(params[:id])
  end
  
  # PATCH/PUT  /users/:id(.:format)
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # DELETE /users/:id(.:format)
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
    private
  
    # Strong Parameter
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeアクション
    
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者ユーザーかどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
