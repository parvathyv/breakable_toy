class Location < ActiveRecord::Base

  has_many :hunts
  has_many :users, through: :hunts

  validates :address, presence: true
  geocoded_by :address

  after_validation :geocode, :if => :address_changed?

  def address_type?(address)

    flag = true
    if address == '' or address == nil
      flag = false
    else
      checklocation = Location.where("address=?", address)
      if checklocation.empty? == false
        flag = false
      end
    end
    flag
  end

end
