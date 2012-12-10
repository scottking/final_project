class AdvertisementsController < ApplicationController
  
  def new
	@board = Board.find(params[:board_id])
    @advertisement = Advertisement.new()
  end

  def create
	@board = Board.find(params[:board_id])
	@advertisement = @board.advertisements.build(params[:advertisement])
    
	if !params[:upload].blank?
	  @advertisment.image = @advertisment.image_contents.read
	end
	
	@advertisement.user = current_user
	#@advertisement.image = @advertisement.image.read
	#@advertisement = Advertisement.new(params[:advertisement])
	#@advertisement = board.build(params[:advertisement])
	#@board = current_user.boards.build(params[:board])
	  #@board.user = current_user
      if @advertisement.save
	    
		#flash[:success] = @advertisement.x_location
		
		#(Integer(@advertisement.x_location)..(Integer(@advertisement.width) + Integer(@advertisement.x_location) - 1)).each do |my_x|
	      #((Integer(@advertisement.y_location)..(Integer(@advertisement.height) + Integer(@advertisement.y_location) - 1)).each do |my_y|
	      
		  #(@advertisement.x_location..(@advertisement.x_location + @advertisement.width).each do |my_x|
		
		#for my_x in Integer(@advertisement.x_location)..(Integer(@advertisement.width) + Integer(@advertisement.x_location) - 1)
	     # for my_y in Integer(@advertisement.y_location)..(Integer(@advertisement.height) + Integer(@advertisement.y_location) - 1)
	        
			
			#@board.advertisements.each do |ad|
			 # @current_tile = ad.tiles.where(:x_location => my_x, :y_location => my_y).first
			  
			  #tiles.where(:x_location => x, :y_location => y).first
		    
			if !@current_tile.nil?
			  @newTile = @advertisement.tiles.build()
			  @newTile.x_location = my_x
			  @newTile.y_location = my_y
			  @newTile.cost = 1
			  @newTile.save
			  
			else
			  
			  @newTile = @advertisement.tiles.build()
			  @newTile.x_location = 0
			  @newTile.y_location = 0
			  
			  
			  #make this the one we should be useing
			  #I'm thinking we need to find current tile in the location
			  #then assign @tile to be new tile in this location
			  #then set @tile.cost = current_tile.cost * 2 || 1
		      
			  #current_cost = @current_tile.cost
		      current_cost = 1
			  
		      new_cost = current_cost * 2
		      if new_cost < 1
		        new_cost = 1
		      end
		      
		      new_cost = new_cost.to_f
		      #@newTile.cost = new_cost
			  
			  @newTile.cost = 10
			  
		      @newTile.save
			  
			end
			
			#end
			
			#end
		
		
	     #end

	    
		/@newTile = @advertisement.tiles.build()
			  @newTile.x_location = 0
			  @newTile.y_location = 0
			  @newTile.cost = 1
			  @newTile.save/
		
		
        flash[:success] = "Advertisement created"
        redirect_to @board
      else
        render 'new'
      end
  end

  def index
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @advertisement = Advertisement.find(params[:id])
    @board = @advertisement.board
	
    if current_user?(@advertisement.user) || current_user?(@board.user)
	  @advertisement.destroy
	  redirect_to board_path(@board)
      
	else
	  redirect_to root_path
	end
  end
  
  def charge
	#find price
  end
  
  
  
end
