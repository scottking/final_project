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
	    #if @board.advertisements == nil
		#  redirect_to root_path
		#end
	    /@advertisement = Advertisement.new
		@advertisement.board = @board
		@advertisement.user = User.find_by_id(1)
		@advertisement.width = @board.width
		@advertisement.height = @board.height
		@advertisement.x_location = 0
		@advertisement.y_location = 0
		if @advertisement.save
		  flash[:success] = "Successfully create new advertisement!"/
		  flash[:success] = "Successfully created new board!"
          redirect_to @board
		/else
		  render 'new'
		end/
        
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
	
	
end
