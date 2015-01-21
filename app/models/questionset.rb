
class Questionset < ActiveRecord::Base

  belongs_to :hunt

  validates :question_no, presence: true,
  :inclusion => {:in => [1,2,3,4,5]}

  validates :question, presence: true, length: { maximum: 300 }
  validates :description, presence: true
  validates :description, length: { maximum: 500 }
  validates :hunt_id, presence: true
  validates_numericality_of :hunt_id, :only_integer => true
  #validates_numericality_of :latitude
  #validates_numericality_of :longitude
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  mount_uploader :hunt_photo, QuestionsetPhotoUploader

  def next
    hunt.questionsets.where("id > ?", id).order("id ASC").first
  end

  def self.if_exists?(huntid)
     where("hunt_id=?",huntid)
  end

  def upto

    hunt.questionsets.where("id < ?", id).order("id ASC")

  end

  def uptoquestion(qno)

    objarr = hunt.questionsets.where("question_no <= ?", qno).order("id ASC")
    arr = objarr.map{|x| [x.latitude, x.longitude]}
    return arr


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
      correctanswer = self.address.upcase.split(',').first
      checkanswer = address.upcase.split(',').first

      if (correctanswer.include? checkanswer) || (checkanswer.include? correctanswer)

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
