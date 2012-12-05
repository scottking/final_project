class AdvertisementsController < ApplicationController
  def new
	@board = Board.find(params[:board_id])
    @advertisement = Advertisement.new
  end

  def create
	@board = Board.find(params[:board_id])
	@advertisement = @board.advertisements.build(params[:advertisement])
    @advertisement.user = current_user
	@advertisement.image = @advertisement.image.read
	#@advertisement = Advertisement.new(params[:advertisement])
	#@advertisement = board.build(params[:advertisement])
	#@board = current_user.boards.build(params[:board])
	  #@board.user = current_user
      if @advertisement.save
        flash[:success] = "Successfully created new advertisement!"
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
  
  def retrieve
    @advertisement_image = Advertisement.find(params[:id])
	send_data File.read(@advertisement_image.abs_filepath), type: "image/jpeg", disposition: 'inline'
  end
  
  
end
