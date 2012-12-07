class UsersController < ApplicationController
  #include ActiveModel::MassAssignmentSecurity
  
  #before_filter :signed_in_user,	only: [:index, :edit, :update, :show]  
  #before_filter :correct_user,		only: [:edit, :update, :show]
  #before_filter :admin_user,     	only: [:index, :show, :destroy]
  
  def show
    if signed_in?
      if current_user?(signed_in_user)
        @user = User.find(params[:id])
        #@boards = Board.find_by_user_id(params[:id]) #this line is added
	    #@microposts = @user.microposts.paginate(page: params[:page])
      else
	    flash[:error] = "Wrong user"
	  end
	else
	  flash[:error] = "Not signed in"
	end
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
        flash[:success] = "Welcome"
        redirect_to @user
      else
        render 'new'
      end
	end
  end
  
  def index
    if signed_in?
      if current_user.admin?
        @users = User.all#paginate(page: params[:page])
	    #@boards = Board.all
	  else
	    flash[:error] = "Not an administrator"
	    redirect_to root_path
	  end
	else 
	  flash[:error] = "Not signed in"
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
		redirect_to(root_path, flash: { error: "Not signed in" } ) unless signed_in?
      end
	end
	
	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, flash: { error: "Wrong user" } ) unless current_user?(@user)
    end
	
	def admin_user
      redirect_to(root_path, flash: { error: "Not an administrator" } ) unless current_user.admin?
    end
end
