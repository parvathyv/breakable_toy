require 'open-uri'
class Questionset < ActiveRecord::Base

  belongs_to :hunt



  validates :question_no, presence: true
  validates :question, presence: true


  validates :address, presence: true


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

  def get_clue

    paragraphs = []
    search_item = self.address.split(',').first

    search_item = search_item.split(' ').each { | word | word.capitalize! }.join(' ')

    if search_item.strip.size > 1
      search_item = search_item.split(' ').join('_')
    end

    search_parameter = search_item



      url = "https://en.wikipedia.org/wiki/#{search_parameter}"



      doc = Nokogiri::HTML(open(url))

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


      paragraphs = paragraphs.map do|paragraph|
        if paragraph.nil? == false
          paragraph = paragraph.gsub(search_parameter, '---')
        end
      end

      paragraphs = paragraphs.map do|paragraph|
        if paragraph.nil? == false
          paragraph = paragraph.gsub(search_parameter.split(' ').first,'---')
        end
      end

      paragraphs = paragraphs.map do|paragraph|
        if paragraph.nil? == false
          paragraph = paragraph.split('.').first
        end
      end

    paragraphs


  end


  def self.get_tree(qid)
    @hunt = Questionset.find(qid).hunts
    @locations = @hunts.locations.first.address
    @hunts = @hunts.locations.first.hunts
    #.map{|hunt| hunt.name}
    #@questionsets = ['F1','F2','F3','F4']
    @my_hash1 = {}
    hash = {}
    hash1= {}
    arr = []
    arr1 = []
    arr2=[]


    1.times do |n|

      @my_hash1["name"] = @locations[n]


    # @hunts.size.times do |n1|
      @hunts.each do|hunt|
        hash = {}
        arr = []
        hash["name"] = hunt.name
        # @hunts[n1]
        arr1 << hash


        #@questionsets.size.times do |n2|
        hunt.questionsets.each do|ques|
          hash1={}
          #arr = []
          hash1["name"] = ques.address
          #@questionsets[n2]
          hash1["size"] = 1000 + rand(120)
          arr << hash1

         end
         hash["children"] = arr
         @my_hash1["children"] = arr1

        end
          # @my_hash1["children"] = hash

         # binding.pry




    end



  end




end
