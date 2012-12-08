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
  
  #after_validation :create_fake_ad#, :create_payment_detail
  
  private
  
    def garbage
      if self.timezone == "garbage"
	    errors.add(:timezone, "Incorrect timezone")
	  end
    end
	
	def create_fake_ad
	  @ad = Advertisement.new
	  
	  #@ad.image = @ad.image_contents.read
	  
	  @user = current_user
	  
	  @ad.user = signed_in_user
	  @ad.x_location = 0
	  @ad.y_location = 0
	  @ad.width = self.width
	  @ad.height = self.height
	  @ad.cost = 0
	  
	  self.advertisements.build(@ad)
	  #@ad = self.advertisements.build(params[:advertisement])
	  
	  if @ad.save
        flash[:success] = "Advertisement created"
        redirect_to self
      else
	    flash[:error] = "Unable to create fake advertisement"
        redirect_to root_path
      end
	  
	end
	
	def create_payment_detail
	  #@payment = Paymentment_details.new
	  
	  #@payment.board = board
	  
	end
  
end
