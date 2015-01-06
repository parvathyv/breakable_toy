class Hunt < ActiveRecord::Base

  belongs_to :location
  belongs_to :user
  has_many :quizzes, dependent:  :destroy

end
