require 'open-uri'
class Questionset < ActiveRecord::Base

  belongs_to :hunt

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def next
    hunt.questionsets.where("id > ?", id).order("id ASC").first
  end

  def upto

    hunt.questionsets.where("id < ?", id).order("id ASC")

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

  def check_answer(address)

     flm = self.is_answer?(address)

      if flm == 0

        if self.get_nonmatch == 'dist'

          dist = self.get_distance(address).round(1)
          msg = " Sorry, you are about #{dist} miles off, try again"
        else
           msg = "Sorry, try again"
        end
      else

         msg = "Great job on guessing #{self.address.split(',').first}.
         #{5 - self.question_no} questions to go "
      end
     msg

  end




end
