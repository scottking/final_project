class BoardsController < ApplicationController
  
  def new
    if !signed_in?
	  flash[:error] = "Not signed in"
	  redirect_to signin_path
	else
	  @board = Board.new
	  #params[:id] #this line is added
	end
  end

  def create
    if !signed_in?
	  redirect_to root_path
	else
	  #@board = Board.new(params[:board])
	  @board = current_user.boards.build(params[:board])
	  #@board.user = current_user
      if @board.save
	    
	    @ad = @board.advertisements.build()
	    #@ad.image = @ad.image_contents.read
	    @ad.user = current_user
	    @ad.x_location = 0
	    @ad.y_location = 0
	    @ad.width = @board.width
	    @ad.height = @board.height
		
		@ad.image = "\assets\images\shawn.jpg"
		@ad.save
        
		/@pay = @board.payment_detail.build()
		#@pay = @board.payables.build()
		#@pay = Payment_Detail.new
		@pay.amount = @board.width * @board.height
		@pay.user = current_user
		
		@pay.save/
		
		
		flash[:success] = "Board created"
        redirect_to @board
      else
	    flash[:error] = "Invalid"
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
	
	
end
