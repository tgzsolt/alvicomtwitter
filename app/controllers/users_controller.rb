class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :liked_microposts, :change_admin_right]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  def index
    @users = User.paginate(page: params[:page], per_page: 8)
    @all_users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], per_page: 8)
    @all_users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 8)
    @all_users = @user.followers
    render 'show_follow'
  end
  
  def liked_microposts
    @title = "Likes"
    @user = User.find(params[:id])
    @liked_microposts = @user.liked_microposts.paginate(page: params[:page], per_page: 8)
    render 'show_liked_microposts'
  end
  
   def change_admin_right
    @user = User.find(params[:id])
    Rails.logger.info(params[:admin])
    if @user.update_attribute(:admin, params[:admin])
      flash[:success] = "Right updated"
      redirect_to(users_path)
    else
      Rails.logger.info(@user.errors.inspect) 
      flash[:success] = "Right not updated"
      redirect_to(users_path)
    end
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
