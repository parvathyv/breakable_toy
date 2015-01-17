class Location < ActiveRecord::Base

  has_many :hunts,  dependent:  :destroy
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


  def self.get_tree(lid)
    @location = Location.find(lid).address
    @hunts = Location.find(lid).hunts




    @my_hash1 = {}
    hash = {}
    hash1= {}
    arr = []
    arr1 = []
    arr2=[]


    1.times do |n|

      @my_hash1["name"] = @location[n]


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
          hash1["name"] = ques.question
          #@questionsets[n2]
          hash1["size"] = 1000 + rand(120)
          arr << hash1

         end
         hash["children"] = arr
         @my_hash1["children"] = arr1

        end
          # @my_hash1["children"] = hash





    end

  @my_hash1

  end


  def self.get_tree1
    @locations = Locations.all
   # @hunts = Location.find(lid).hunts




    @my_hash1 = {}
    hash = {}
    hash1= {}
    hashmain={}
    arr = []
    arr1 = []
    arr2=[]


    1.times do |n|

      @my_hash1["name"] = 'Locations'


    # @hunts.size.times do |n1|
      @locations.each do|loc|
        hash = {}
        arr = []
        hash["name"] = loc.address
        # @hunts[n1]
        arr1 << hash

        loc.hunts.each do|hunt|
        hashmain = {}
        arr = []
        hash["name"] = loc.address
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



    end

    end

  @my_hash1

  end

end
