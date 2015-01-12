require 'open-uri'
class Questionset < ActiveRecord::Base

  belongs_to :hunt



  validates :question_no, presence: true
  validates :question, presence: true


  validates :address, presence: true
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

  def get_clue

    paragraphs = []
    search_item = self.address.split(', ').first

    search_item = search_item.split(' ').each { | word | word.capitalize! }.join(' ')

    if search_item.strip.size > 1
      search_item = search_item.split(' ').join('_')
    end

    search_parameter = search_item

    begin

      url = "https://en.wikipedia.org/wiki/"+ "#{search_parameter}"


      doc = Nokogiri::HTML(open(url).read) do


      characters = doc.css("#mw-content-text p")


      if characters[1].to_s.length > 100 && characters[0].to_s.length < 10
        paragraphs << characters[1].to_s.split(',').first
        paragraphs << characters[1].to_s.split(',')[1]
        paragraphs << characters[1].to_s.split(',')[2]
      else
        paragraphs << characters[0].to_s.split(',').first
        paragraphs << characters[0].to_s.split(',')[1]
        paragraphs << characters[0].to_s.split(',')[2]
      end

      search_parameter = search_parameter.split('_').join(' ')
     end


     rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        paragraphs << "Clue not found"
        paragraphs << "Please try being more specific"
        paragraphs << "Else answer the question the best you can"
      else
          raise e
      end
    end

    paragraphs


  end




end
