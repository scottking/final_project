class PaymentDetailsController < ApplicationController

  def new
    @board = Board.find(params[:board_id])
    @payment_detail = Payment_detail.new
  end
  
  def create
    @payment_detail = Board.find(params[:board_id]).payment_details.build(params[:pament_detail])
	
	if @payment_detail.save
	  flash[:success] = "Payment_detail created"
      redirect_to @board
	  
	else
	  flash[:error] = "Invalid"
	  render 'new'
	end
  end
end
