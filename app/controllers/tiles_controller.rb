class TilesController < ApplicationController
	
	def new
	  @board = Board.find(params[:board_id])
	  @advertisement = Advertisement.find(params[:advertisement_id])
	  #@board = @advertisement.board
	  @tile = Tile.new()
	end
	
	def create
	  @board = Board.find(params[:board_id])
	  @advertisement = Advertisement.find(params[:advertisement_id])
	  @tile = @advertisement.tiles.build(params[:tile])
	  #cost = 0
	  if @tile.save
	    flash[:success] = "Tile created"
		redirect_to @advertisement
	  else
	    render 'new'
	  end
	  
	end
	
	def destroy
	  @board = Board.find(params[:board_id])
	  @advertisement = Advertisement.find(params[:advertisement_id])
	  
	  
	  @destroy_tile = Tile.find(params[:id])
	  @destroy_tile.destroy
	  flash[:success] = "Tile destroyed"
	end
	
	def index
	  @board = Board.find(params[:board_id])
	  @ad = Advertisement.find(params[:advertisement_id])
	  @tiles = @ad.tiles.all
	end
	
	def age
	end
	
end
