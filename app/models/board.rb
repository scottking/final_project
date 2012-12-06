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
  
  private
  
    def garbage
      if self.timezone == "garbage"
	    errors.add(:timezone, "Incorrect timezone")
	  end
    end
  
end
