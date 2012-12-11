class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  attr_protected :user_id
  
  has_many :tiles, through: :advertisements
  has_many :advertisements
  
  has_one :payment_detail, as: :payable
  
  belongs_to :user
  
  validates :name, 		presence: true
  validates :height, 	presence: true, numericality: { greater_than: 0}
  validates :width,  	presence: true, numericality: { greater_than: 0 }
  #validates :timezone,	presence: true
  validates :timezone, presence: true, inclusion: {in: ActiveSupport::TimeZone.zones_map(&:to_s)}  
  
  #validate :garbage
  
  after_create :create_fake_ad#, :create_payment_detail
  after_create :create_payment
  
	
	def create_fake_ad
	  
	  @ad = advertisements.build()
	    #@ad.image = @ad.image_contents.read
	    @ad.user = user
	    @ad.x_location = 0
	    @ad.y_location = 0
	    @ad.width = width
	    @ad.height = height
		
		@ad.image = "\assets\images\shawn.jpg"
		@ad.save
	  
	end
	
	def create_payment
	
	  @payment = user.payment_details.build(amount: width * height)
	  @payment.amount = width * height
	  @payment.payable = self
	  
	  @payment.save
	  
	end
  
  def age
    
  end
  
  private
  
    def garbage
      if self.timezone == "garbage"
	    errors.add(:timezone, "Incorrect timezone")
	  end
    end
end
