class UsersController < ApplicationController
  
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
  
    private
  
    # Strong Parameter
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
