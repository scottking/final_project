class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id
  
  has_many :tiles
  has_many :payment_details, as: :payable
  
  belongs_to :user
  belongs_to :board

  validates :x_location, 	presence: true, numericality: { greater_than_or_equal_to: 0}#also less than board_id.height
  validates :y_location, 	presence: true, numericality: { greater_than_or_equal_to: 0}#ad spec number 48,65
  validates :height, 		presence: true, numericality: { greater_than: 0}#also less than board_id.height
  validates :width, 		presence: true, numericality: { greater_than: 0}#also less than boad_id.width
  validates :image, 		presence: true
  validates :board, 		presence: true
  
  validate :sizing
  
  before_save :make_tiles
  
  def image_contents=(object)
	self.image = object.read()
  end
  
  def make_tiles
    #for self.width
  end
  
  private
  
    def sizing
	  if x_location.is_a?(Integer) && y_location.is_a?(Integer) && width.is_a?(Integer) && height.is_a?(Integer)
	  
      if self.x_location >= self.board.width
	    errors.add(:x_location, "Can't be larger than width")
	  end
	  
	  if self.y_location >= self.board.height
	    errors.add(:y_location, "Can't be larger than height")
	  end
	  
	  if self.x_location + self.width > self.board.width
	    errors.add(:x_location, 	"Can't be larger than width (combination error)")
	    errors.add(:width, 		"Can't be larger than width (combination error)")
	  end
	  
	  if self.y_location + self.height > self.board.height
	    errors.add(:y_location, 	"Can't be larger than height (combination error)")
	    errors.add(:height, 		"Can't be larger than height (combination error)")
	  end
	  
	  end
    end
  
  
end

