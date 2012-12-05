class UsersController < ApplicationController
  #include ActiveModel::MassAssignmentSecurity
  
  before_filter :signed_in_user,	only: [:index, :edit, :update, :destroy]  
  before_filter :correct_user,		only: [:edit, :update]
  #before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
	@boards = Board.find_by_user_id(params[:id]) #this line is added
	#@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    if signed_in?
	  redirect_to root_path
	else
	  @user = User.new
	end
  end
  
  def create
	if signed_in?
	  redirect_to root_path
	else
	  @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to my final project!!"
        redirect_to @user
      else
        render 'new'
      end
	end
  end
  
  def index
    if current_user.admin?
      @users = User.all#paginate(page: params[:page])
	  #@boards = Board.all
	else
	  redirect_to root_path
	end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    #if signed_in? && current_user.admin?
	  #notice: "You can't destroy yourself."
	#else
	User.find(params[:id]).boards.destroy
    User.find(params[:id]).destroy
	flash[:success] = "User destroyed."
	redirect_to users_url
	  #redirect_to root_path
	#end
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
  
  #def following
  #  @title = "Following"
  #  @user = User.find(params[:id])
  #  @users = @user.followed_users.paginate(page: params[:page])
  #  render 'show_follow'
  #end

  #def followers
  #  @title = "Followers"
  #  @user = User.find(params[:id])
  #  @users = @user.followers.paginate(page: params[:page])
  #  render 'show_follow'
  #end
  
  private

    def signed_in_user
	  unless signed_in?
		store_location
		redirect_to signin_url, notice: "Please sign in." unless signed_in?
      end
	end
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
	
	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
