class UsersController < ApplicationController

  before_action :setUser,only: [:show, :edit, :update, :destroy]
   before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])   
  end 
  
  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new 
    @user = User.new    
  end
  
  def edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
    
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        format.html{render :edit}    
      end
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private  def user_params
    params.require(:user).permit(:name,:mail,:password,:password_confirmation)
  end
  
  private def setUser
    @user = User.find(params[:id])
  end
  
  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
end