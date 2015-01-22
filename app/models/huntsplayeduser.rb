class Huntsplayeduser < ActiveRecord::Base

  belongs_to :hunt
  belongs_to :user
  validates :question_no, presence: true,
  :inclusion => {:in => [1,2,3,4,5]}
  validates :hunt_id, presence: true
  validates_numericality_of :hunt_id, only_integer: true
  validates :user_id, presence: true
  validates_numericality_of :user_id, only_integer: true

  validates :user_session_id, presence: true
  validates :user_session_id,
  length: {
  minimum: 32,
  maximum: 32
  }
  validates :address, presence: true
  validates_uniqueness_of :question_no, scope: [:hunt_id, :user_id, :user_session_id]


  def self.hunt_check(qno, hunt_id, usid)

    where("question_no <= ? and hunt_id=? and user_session_id=?", qno, hunt_id, usid).last

  end

  def self.if_exists?(hunt_id, usid, uid)

    where("hunt_id=? and user_session_id=? and user_id=? and question_no < 6 " , hunt_id, usid, uid)
  end

  def self.find_hunts(user_id)

    where("user_id=?", user_id).group(:hunt_id).count(:id)

  end



end
