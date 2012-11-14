class Tile < ActiveRecord::Base
  attr_accessible :advertisement_id, :board_id, :cost, :x_loc, :y_loc
  
  belongs_to :board
  belongs_to :advertisement
  
end
