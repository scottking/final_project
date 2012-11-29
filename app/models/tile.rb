class Tile < ActiveRecord::Base
  attr_accessible :x_location, :y_location
  
  has_one :board, through: :advertisement
  belongs_to :advertisement
  
  validates :x_location, presence: true, numericality: { greater_than_or_equal_to: 0 }#less than board width, greater than ad x_loc
  validates :y_location, presence: true, numericality: { greater_than_or_equal_to: 0 }#65, 74, 84 -- 101, 110, 120
  validates :cost, presence: true, numericality: { greater_than: 0 }  
  
  validate :sizing
  
  private
  
    def sizing
	  if x_location.is_a?(Integer) && y_location.is_a?(Integer)
	  
      if self.x_location >= self.board.width
	    errors.add(:x_location, "Can't be larger than the width")
	  end
	  
	  if self.x_location < self.advertisement.x_location
	    errors.add(:x_location, "Can't be smaller than advertisement")
	  end
	  
	  if self.advertisement.x_location + self.advertisement.width - 1 <= self.x_location
	    errors.add(:x_location, "Larger than specified width")
	  end
	  
	  if self.y_location >= self.board.height
	    errors.add(:y_location, "Larger than board")
	  end
	  
	  if self.y_location < self.advertisement.y_location
	    errors.add(:y_location, "Smaller than advertisement location")
	  end
	  
	  if self.advertisement.y_location + self.advertisement.height - 1 <= self.y_location
	    errors.add(:y_location, "Larger than specified height")
	  end
	  
	  end
    end
  
end
