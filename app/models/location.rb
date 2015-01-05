class Location < ActiveRecord::Base

  has_many :hunts
  has_many :users, through: :hunts

  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end
