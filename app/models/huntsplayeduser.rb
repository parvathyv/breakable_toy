class Huntsplayeduser < ActiveRecord::Base

  has_many :hunts
  has_and_belongs_to_many :users
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
