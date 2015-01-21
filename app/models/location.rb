class Location < ActiveRecord::Base

  has_many :hunts,  dependent:  :destroy
  has_many :users, through: :hunts
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates_numericality_of :latitude
  validates_numericality_of :longitude
  validates :address, presence: true

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

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

    @hunts = Location.find(lid).hunts.map{|hunt|  hunt if hunt.questionsets.count == 5}
    @hunts.reject! { |hunt| hunt == nil }

    @my_hash1 = {}
    hash = {}
    hash1= {}
    arr = []
    arr1 = []
    arr2=[]


    1.times do |n|

      @my_hash1["name"] = @location

      @hunts.each do|hunt|
        if hunt.questionsets.count == 5
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



    else


        @my_hash1 = {"name"=>"Boston, MA",
                     "children"=>
                      [{"name"=>"Freedom Trail",
                        "children"=>
                         [{"name"=>"Boston Commons, Boston, MA", "size"=>1048},
                          {"name"=>"Paul Revere House, Boston, MA", "size"=>1067},
                          {"name"=>"King's Chapel, Boston, MA", "size"=>1055},
                          {"name"=>"USS Constitution, Boston, MA", "size"=>1028},
                          {"name"=>"Old State House, Boston, MA", "size"=>1096}]}]}
      end


    end
   end
   @my_hash1

  end

end
