class Location < ActiveRecord::Base

  has_many :hunts,  dependent:  :destroy
  has_many :users, through: :hunts
  validates :latitude, numericality: true
  validates :longitude, numericality: true
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
        arr1 << hash
        sample_order = hunt.questionsets.shuffle

        sample_order.each do|ques|
          hash1={}

          hash1["name"] = ques.address

          hash1["size"] = 1000 + rand(120)
          arr << hash1

         end

         hash["children"] = arr
         @my_hash1["children"] = arr1

        end

    end

  @my_hash1

  end

end
