class Huntsplayeduser < ActiveRecord::Base

  has_many :hunts
  has_and_belongs_to_many :users


end
