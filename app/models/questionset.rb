require 'open-uri'
class Questionset < ActiveRecord::Base

  belongs_to :hunt

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def next
    hunt.questionsets.where("id > ?", id).order("id ASC").first
  end

  def get_distance(address)

      lat = address.split(',').first.to_f
      lng = address.split(',')[1].to_f
      dist = Geocoder::Calculations.distance_between([lat, lng], [self.latitude,self.longitude])

  end

  def is_answer?(address)
    flag = 0
    if address.split(',').first.to_f != 0
      dist = self.get_distance(address)

      if dist < 0.5
        flag = 1
      else
        @nonmatch = 'dist'
      end
    else
      if self.address.include? address
        flag = 1
      else
        @nonmatch = 'address'
      end
    end

    flag
  end

  def get_nonmatch
    @nonmatch
  end





end
