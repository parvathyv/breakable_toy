class Hunt < ActiveRecord::Base

  belongs_to :location
  belongs_to :user
  has_many :questionsets, dependent:  :destroy

  validates :name, presence: true,
  length: {
  minimum: 4,
  maximum: 50
  }

  validates :description, presence: true,
   length: { maximum: 500 }

end
