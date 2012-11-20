class Board < ActiveRecord::Base
  attr_accessible :height, :name, :timezone, :width
  
  has_many :tiles, through: :advertisements
  has_many :advertisements
  
  has_one :payment_detail, as: :payable
  
  belongs_to :user
  
  validates :name, 		presence: true
  validates :height, 	numericality: { greater_than: 0}
  validates :width,  	numericality: { greater_than: 0 }
  validates :timezone,	presence: true
  #validates_inclusion_of :time_zone, presence: true, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Time Zone"

  
  #validate :garbage
  
  private
  
    def garbage
      if timezone == "garbage"
	    errors.add(:timezone, "Incorrect timezone")
	  end
    end
  
end
