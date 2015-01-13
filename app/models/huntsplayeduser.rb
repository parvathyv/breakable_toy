class Huntsplayeduser < ActiveRecord::Base

  has_many :hunts
  has_and_belongs_to_many :users

  def self.hunt_check(qno, hunt_id)

    where("question_no <= ? and hunt_id=?", qno, hunt_id).last

  end

  def self.if_exists?(hunt_id, usid, uid)

    where("hunt_id=? and user_session_id=? and user_id=? and question_no < 6 " , hunt_id, usid, uid)
  end


end
