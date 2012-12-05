class BoardsController < ApplicationController
  
  def new
    if !signed_in?
	  redirect_to signin_path
	else
	  @board = Board.new
	  #params[:id] #this line is added
	end
  end

  def create
    if !signed_in?
	  redirect_to signin_path
	else
	  #@board = Board.new(params[:board])
	  @board = current_user.boards.build(params[:board])
	  #@board.user = current_user
      if @board.save
        flash[:success] = "Successfully created new board!"
        redirect_to @board
      else
        render 'new'
      end
	end
  end

  def show
    @board = Board.find(params[:id])
	@showboard = @board.advertisements.all
	#@user = User.find_by_id(@showboard)
	
  end

  def index
    @boards = Board.all
  end

  def edit
  end

  def update
  end

  def destroy
    
    Board.find(params[:id]).advertisements.destroy
    Board.find(params[:id]).destroy
	flash[:success] = "Board destroyed."
	redirect_to boards_path
  end
  
  private
    
	def createdBy
	  self.User.name
	end
	
	
end
